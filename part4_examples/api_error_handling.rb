#!/usr/bin/env ruby
require 'chef'
chef_server_url = "http://127.0.0.1:8889"
client_name = "cctest"
signing_key_filename="/tmp/part4_examples/customizing_chef.pem"
env = ARGV[0]

# Our API calls will be inside a begin..rescue block this time
begin
  rest = Chef::REST.new(chef_server_url, client_name, signing_key_filename)

  # Make a GET call to /environments/NAME with the environment
  # name passed in on the command line
  returned_data = rest.get_rest("/environments/#{env}")
  puts returned_data

  # Only catch exceptions of type Net::HTTPServerException
rescue Net::HTTPServerException => e
  # If the response code was 404...
  if e.response.code == "404"
    # Print our nice error message and exit with exit code 1
    puts "The environment #{env} does not exist."
    exit 1
  else
    # Reraise the exception
    raise e
  end
end