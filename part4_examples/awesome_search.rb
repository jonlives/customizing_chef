module Awesome
  class AwesomeSearch < Chef::Knife

    deps do
      require 'chef/knife/search'
    end

    def run
      # Assign the first command-line argument
      # after the plugin name to the variable "query"
      query = "name:*#{name_args.first}* AND chef_environment:_default"
      knife_search = Chef::Knife::Search.new
      knife_search.name_args = ['node', query]
      knife_search.run
    end
  end
end