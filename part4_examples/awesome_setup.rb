module AwesomeInc
  class AwesomeSetup < Chef::Knife

    # Lazily load our dependencies
    deps do
      require 'chef/node'
      require 'chef/knife/core/object_loader'
    end

    # Specify the banner to show when options are not specified
    banner "knife awesome setup NODE ENVIRONMENT (options)"

    option :interactive_edit,
           :short => "-i",
           :long => "--interactive-edit",
           :description => "Allows node to be edited interactively"

    def run
      # Assign our parameters to variables for convenience
      node_name = name_args.first
      environment_name = name_args.last

      # Verify that our required options have been specified
      if node_name.nil? or environment_name.nil?
        show_usage
        ui.fatal("You must specify a node name and an environment")
        exit 1
      end

      # Load the node object
      ui.msg "Loading node #{node_name}"
      node_object = Chef::Node.load(node_name)

      # Set the chef_environment of the node object to the
      # specified environment
      ui.msg "Setting environment of #{node_object} to #{environment_name}"
      node_object.chef_environment = environment_name

      # If the -i option was specified...
      if config[:interactive_edit]
        # Then let the user edit the object interactively
        ui.info "Interactive edit requested, opening #{node_name} in configured editor:"
        edited_object = ui.edit_data(node_object)
      end

      # Finally, save the object
      final_object = edited_object || node_object
      ui.info "Saving #{final_object}"
      final_object.save
    end
  end
end