module AwesomeInc
  class AwesomeObjectDemo < Chef::Knife

    deps do
      require 'chef/node'
    end

    def run
      node_object = Chef::Node.load(name_args.first)

      # Print our node's chef_environment before we change it
      ui.msg "chef_environment is currently #{node_object.chef_environment}"
      node_object.chef_environment = name_args.last

      # Print our node's chef_environment again after we change it
      ui.msg "chef_environment is currently #{node_object.chef_environment}"
      node_object.save
    end
  end
end