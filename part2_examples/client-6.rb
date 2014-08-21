verify_api_cert true
require "/tmp/part2_examples/awesome_subscriber_start_handler.rb"
awesome_subscriber_start_handler = Chef::Handler::AwesomeSubscriberStartHandler.new
start_handlers << awesome_subscriber_start_handler