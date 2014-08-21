#!/usr/bin/env ruby

# Require our dependencies (all in Ruby standard library)
require "base64"
require 'digest/sha1'
require "net/http"
require "uri"

# Print an error if no command-line argument given
if ARGV.empty?
  puts "ERROR: You must supply a path to request from the API"
  exit 1
end

# Our client key, client name, and Chef server URL
client_key = "/tmp/part4_examples/customizing_chef.pem"
client_name = "cctest"
chef_server = "http://127.0.0.1:8889"

# The path to call will be our first command-line parameter
path = ARGV[0]

# We're going to do a GET request, so the request body
# will be empty
body = ""

# Base64 encode the path and body of our request
hashed_path = Base64.encode64(Digest::SHA1.digest(path)).chomp
hashed_body = Base64.encode64(Digest::SHA1.digest(body)).chomp

# Generate timestamp
timestamp = Time.now.strftime("%Y-%m-%dT%H:%M:%SZ").to_s

# Construct our first set of headers, some of which will be used
# to construct the X-Ops-Authorization headers next
headers = {'X-Ops-Timestamp' => timestamp,
           'X-Ops-Userid' => client_name,
           'X-Chef-Version' => '11.10.0',
           'Accept' => 'application/json',
           'X-Ops-Content-Hash' => hashed_body,
           'X-Ops-Sign' => 'version=1.0'
          }

# Construct the specially formatted string needed to generate
# X-Ops-Authorization headers. This string must always be in the
# format and order shown here and contain the headers shown.
canonical_request="Method:GET\\n" +
    "Hashed Path:#{hashed_path}\\n" +
    "X-Ops-Content-Hash:#{hashed_body}\\n" +
    "X-Ops-Timestamp:#{timestamp}\\n" +
    "X-Ops-UserId:#{client_name}"
# Sign our canonical_request string with the specified client key
command = `printf \"#{canonical_request}\" |
openssl rsautl -sign -inkey #{client_key}`
signed_hash = `#{command}`

# Then encode it as Base64 and split the encoded hash into 60-char-long lines
encoded_hash = Base64.encode64(signed_hash).gsub("\n","").scan(/.{1,60}/m)

# Split up our newly constructed X-Ops-Authorization headers
# and add them to the headers hash
encoded_hash.each_with_index do |text,index|
  headers["X-Ops-Authorization-#{index+1}"] = text
end

# Then output our final headers to screen
puts "Request Headers:"
headers.each{|key,value|puts "#{key}:#{value}"}

# Construct the full path we're going to request from the API
full_path = "#{chef_server}#{path}"
puts ""
puts "Making GET request to #{full_path}"

# Parse the full_path into a URI object
uri = URI.parse(full_path)

# Initialize our Net::HTTP object
http = Net::HTTP.new(uri.host, uri.port)

# Use SSL if our Chef server URL contained https://
if uri.scheme == "https"
  http.use_ssl = true

  # Ignore self-signed SSL cert errors
  # DO NOT DO THIS IN PRODUCTION CODE!!!
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
end

# Create a new Net::HTTP::Get object, which we populate with
# our headers
request = Net::HTTP::Get.new(uri.request_uri,headers)

# Finally, send the request to the API
resp = http.request(request)

# Print the response code and body of our request
puts "Response Code: #{resp.code}"
puts "Response Body: #{resp.body}"