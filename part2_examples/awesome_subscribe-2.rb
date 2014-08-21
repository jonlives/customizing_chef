require "chef/event_dispatch/base"
class AwesomeSubscriber < Chef::EventDispatch::Base
# Method to write a message string to our output file
  def write_to_file(message)
    File.open('/tmp/subscriber_output', 'a') do |f|
      f.write("#{self.class} #{Time.now}: #{message}\n")
    end
  end
# Methods overridden from Chef::EventDispatch::Base
  def run_started(run_status)
    write_to_file("run_started: Run started")
  end
  def converge_start(run_context)
    write_to_file("converge_start: Coo")
  end
  def converge_complete
  end
  def resource_up_to_date(new_resource, action)
    write_to_file("resource_up_to_date: Resource #{new_resource} " +
                      "action #{action} already up to date")
  end
  def resource_updated(new_resource, action)
    write_to_file("resource_updated: Resource #{new_resource} was " +
                      "updated with action #{action}")
  end
  def run_completed(node)
    write_to_file("run_completed: Run completed")
  end
  def run_failed(exception)
    write_to_file("run_failed: Run failed with #{exception}")
  end
end