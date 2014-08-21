class Chef
  class Resource
    class AwesomeBackup < Chef::Resource

      provides :awesome_backup, :on_platforms => :all

      def initialize(name, run_context=nil)
        super
        @resource_name = :awesome_backup
        @allowed_actions = [:compress, :extract]
        @action = :compress

        # Now we need to set up any resource defaults
        @name = name
        @backup_file = nil
        @cleanup = false
        @num_backups = 3
      end

      # Create methods to get and set our attribute values
      def name(arg=nil)
        set_or_return(:name, arg, :kind_of => String)
      end

      def backup_file(arg=nil)
        set_or_return(:backup_file, arg, :kind_of => String)
      end

      def cleanup(arg=nil)
        set_or_return(:cleanup, arg, :kind_of => [TrueClass, FalseClass])
      end

      def num_backups(arg=nil)
        set_or_return(:num_backups, arg, :kind_of => Fixnum)
      end
    end
  end
end