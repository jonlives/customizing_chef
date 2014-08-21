class Chef
  class Node

    def interface_statuses(&block)
      node[:network][:interfaces].each do |name, info|
        block.call(name, info["state"])
      end
    end
  end
end