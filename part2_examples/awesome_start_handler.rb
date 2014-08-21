require "chef/handler"
class Chef
  class Handler
    class AwesomeStartHandler < Chef::Handler
      # Override report method from Chef::Handler
      def report
        # Print a log message when our handler is executed
        Chef::Log.warn("Handler #{self.class} executed")
        # Grab data from the @run_status object
        # and assign to local variables for clarity
        run_start_time = @run_status.start_time
        node_name = @run_status.node.name
        # Open output file in append mode and write handler output to it
        File.open("/tmp/handler_output", 'a') do |file|
          file.write("\n#{self.class}: Run started on #{node_name} at " +
                         "#{run_start_time}\n")
        end
      end
    end
  end
end