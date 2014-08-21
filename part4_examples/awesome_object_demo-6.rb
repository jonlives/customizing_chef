module AwesomeInc
  class AwesomeObjectDemo < Chef::Knife

    deps do
      require 'chef/knife/core/object_loader'
    end

    def run
      loader = Chef::Knife::Core::ObjectLoader.new(Chef::Environment, ui)
      ui.msg "Loading #{name_args.first}"
      environment_object = loader.load_from('environments', @name_args.first)
      ui.msg "Saving environment #{name_args.first}"
      environment_object.save
    end
  end
end