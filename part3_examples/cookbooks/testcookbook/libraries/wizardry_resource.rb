class Chef
  class Resource
    class Wizardry < Chef::Resource

      provides :wizardry, :on_platforms => :all

      def initialize(name, run_context=nil)
        super
        @resource_name = :awesome_backup
        @allowed_actions = [:magic]
        @action = :magic
        @provider = Chef::Provider::TestcookbookHogwarts
        @name = name
      end

      def name(arg=nil)
        set_or_return(:name, arg, :kind_of => String)
      end
    end
  end
end