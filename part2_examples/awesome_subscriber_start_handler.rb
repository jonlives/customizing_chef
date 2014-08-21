require "chef/handler"
require "/tmp/part2_examples/awesome_subscriber.rb"
class Chef
  class Handler
    class AwesomeSubscriberStartHandler < Chef::Handler
      def report
        event_dispatcher_subscriber = AwesomeSubscriber.new
        @run_status.events.register(event_dispatcher_subscriber)
      end
    end
  end
end