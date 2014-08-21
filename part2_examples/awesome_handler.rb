require "chef/handler"
class Chef
  class Handler
    class AwesomeHandler < Chef::Handler
      def report
        # Existing logic from our report handler
        # If the run was successful, run this code
        if @run_status.success?
          # Grab data from the @run_status object
          # and assign to local variables for clarity
          run_elapsed_time = @run_status.elapsed_time
          node_name = @run_status.node.name
          resource_count = @run_status.all_resources.length
          updated_resources = @run_status.updated_resources
          updated_resource_count = updated_resources.length
          # Open output file in append mode and write handler output to it
          File.open("/tmp/handler_output", 'a') do |file|
            file.write("\n#{self.class}: Run successfully completed on " +
                           "#{node_name} and took " +
                           "#{run_elapsed_time} seconds:\n")
            file.write(" #{resource_count} resources in total, " +
                           "#{updated_resource_count} updated:\n")
            # Write each resource in the updated_resources list to our
            # output file
            updated_resources.each do |resource|
              m = "recipe[#{resource.cookbook_name}::" +
                  "#{resource.recipe_name}]" +
                  " ran '#{resource.action}' on #{resource.resource_name}" +
                  " '#{resource.name}'"
              file.write(" #{m}\n")
            end
          end
        # New logic to implement exception handler behavior
        # If the run failed, run this code
        elsif @run_status.failed?
          # Grab data from the @run_status object
          # and assign to local variables for clarity
          run_elapsed_time = @run_status.elapsed_time
          node_name = @run_status.node.name
          exception = @run_status.exception
          backtrace = @run_status.backtrace
          # Open output file in append mode and write handler output to it
          File.open("/tmp/handler_output", 'a') do |file|
            file.write("\n#{self.class}: Run failed on " +
                           "#{node_name} after #{run_elapsed_time} seconds:\n")
            file.write(" Exception: #{exception}\n")
            file.write(" Backtrace: \n")
            backtrace.each do |b|
              file.write(" #{b} \n")
            end
          end
        end
      end
    end
  end
end