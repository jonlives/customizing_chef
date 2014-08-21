verify_api_cert true
require "/tmp/part2_examples/awesome_start_handler.rb"
example_start_handler = Chef::Handler::AwesomeStartHandler.new
start_handlers << example_start_handler