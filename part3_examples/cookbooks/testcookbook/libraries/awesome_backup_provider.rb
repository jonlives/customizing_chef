class Chef
  class Provider
    class AwesomeBackup < Chef::Provider
      def whyrun_supported?
        true
      end

      def load_current_resource
        @current_resource = Chef::Resource::AwesomeBackup.new(new_resource.name)
        @current_resource.backup_file(new_resource.backup_file)
        @current_resource.cleanup(new_resource.cleanup)
        @current_resource.num_backups(new_resource.num_backups)
      end

      # Define methods for our actions
      def action_compress
      end

      def action_extract
      end
    end
  end
end