#!/usr/bin/env ruby
require 'chef'
require 'uri'

chef_server_url = "http://127.0.0.1:8889"
client_name = "cctest"
signing_key_filename="/tmp/part4_examples/customizing_chef.pem"

type = "node"
name = ARGV[0]

keys = {
    name: [ 'name' ],
    environment: [ 'chef_environment' ]
}

rest = Chef::REST.new(chef_server_url, client_name, signing_key_filename)

returned_data = rest.post_rest("search/#{type}?q=" +
                                   "#{URI.escape("name:#{name}")}", keys)

puts returned_data