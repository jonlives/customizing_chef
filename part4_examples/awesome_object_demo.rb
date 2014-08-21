module AwesomeInc
  class AwesomeObjectDemo < Chef::Knife
    deps do
      require 'chef/search/query'
    end
    def run
      search_object = Chef::Search::Query.new
      query = "name:*#{name_args.first}*"
      search_object.search('node', query) do |item|
        ui.msg "#{item.name}: #{item.class}"
      end
    end
  end
end