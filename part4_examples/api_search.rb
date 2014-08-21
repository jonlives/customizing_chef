#!/usr/bin/env ruby

require 'chef'
require 'uri'

chef_server_url = "http://127.0.0.1:8889"
client_name = "cctest"
signing_key_filename="/tmp/part4_examples/customizing_chef.pem"

index = "node"
name = ARGV[0]

rest = Chef::REST.new(chef_server_url, client_name, signing_key_filename)

returned_data = rest.get_rest("search/#{index}?q=#{URI.escape("name:#{name}")}")

puts returned_data