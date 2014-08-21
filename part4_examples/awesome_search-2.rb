module AwesomeInc
  class AwesomeSearch < Chef::Knife

    deps do
      require 'chef/search/query'
      require 'chef/knife/core/node_presenter'
    end

    banner "knife awesome search QUERY"

    def run
      ui.use_presenter Chef::Knife::Core::NodePresenter
      search_object = Chef::Search::Query.new
      query = "name:*#{name_args.first}*"
      result_items = []
      result_count = 0

      # Call the method of our Chef::Search::Query
      # object and add each item to our results array; also
      # increment our results counter
      search_object.search('node', query) do |item|
        result_items << item
        result_count += 1
      end

      # Display the number of results we have as a "Warning"
      ui.warn "#{result_count} Nodes found in the _default environment:"
      ui.warn("\n")

      # Loop over our results
      # and output them
      result_items.each do |item|
        output(item)
        unless config[:id_only]
          ui.msg("\n")
        end
      end
    end
  end
end