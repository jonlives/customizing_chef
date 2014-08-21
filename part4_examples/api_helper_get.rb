#!/usr/bin/env ruby
require 'chef'

# Print an error if no command-line argument given
if ARGV.empty?
  puts "ERROR: You must supply a path to request from the API"
  exit 1
end

chef_server_url = "http://127.0.0.1:8889"
client_name = "cctest"
signing_key_filename="/tmp/part4_examples/customizing_chef.pem"
path = ARGV[0]

rest = Chef::REST.new(chef_server_url, client_name, signing_key_filename)

returned_data = rest.get_rest(path)

puts returned_data