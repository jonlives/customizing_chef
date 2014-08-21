class Chef
  class Provider
    class TestcookbookMixerate < Chef::Provider

      def whyrun_supported?
        true
      end

      def load_current_resource
        @current_resource = Chef::Resource::TestcookbookMixerate.new(
            new_resource.name)
      end

      def action_magic
        Chef::Log.warn("Magic has happened!")
      end
    end
  end
end