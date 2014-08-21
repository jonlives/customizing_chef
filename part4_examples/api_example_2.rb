#!/usr/bin/env ruby
require 'chef'
chef_server_url = "http://127.0.0.1:8889"
client_name = "cctest"
signing_key_filename="/tmp/part4_examples/customizing_chef.pem"

rest = Chef::REST.new(chef_server_url, client_name, signing_key_filename)

# GET a list of environments by calling the /environments endpoint
environment_list = rest.get_rest("/environments")

# Iterate over our environments list
environment_list.each do |env|
  env_name = env.first
  puts "Checking environment #{env_name}"

  # For each environment we got back, GET that environment
  # by calling the /environments/NAME endpoint
  env_object = rest.get_rest(env.last)

  # Check if the environment has an empty description attribute
  if env_object.description.empty?
    puts "Description empty, updating..."
    env_object.description("This is the #{env_object.name} environment")

    # Save the environment back to the server by making a
    # PUT request to the /environments/NAME endpoint
    puts "Saving #{env_object.name} environment to the server"
    rest.put_rest("/environments/#{env_object}",env_object)
  else
    puts "Description OK"
  end
end