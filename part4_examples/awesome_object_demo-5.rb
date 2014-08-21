module AwesomeInc
  class AwesomeObjectDemo < Chef::Knife
    deps do
      require 'chef/node'
    end
    def run
      node_object = Chef::Node.load(name_args.first)
      ui.msg "Setting chef_environment of #{name_args.first}" +
                 " to #{name_args.last}"
      node_object.chef_environment(name_args.last)
      output = ui.edit_data(node_object)
      ui.msg "Saving #{output}"
      output.save
    end
  end
end