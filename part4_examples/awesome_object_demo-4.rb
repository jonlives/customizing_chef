module AwesomeInc
  class AwesomeObjectDemo < Chef::Knife
    def run
      ui.edit_object(Chef::Node, name_args.first)
    end
  end
end