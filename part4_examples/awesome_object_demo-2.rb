module AwesomeInc
  class AwesomeObjectDemo < Chef::Knife

    deps do
      require 'chef/node'
    end

    def run
      node_object = Chef::Node.load(name_args.first)
      ui.msg "#{node_object.name}: #{node_object.class}"
    end
  end
end