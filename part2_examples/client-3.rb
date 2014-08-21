verify_api_cert true
require "/tmp/part2_examples/awesome_start_handler.rb"
require "/tmp/part2_examples/awesome_handler.rb"
example_start_handler = Chef::Handler::AwesomeStartHandler.new
example_handler = Chef::Handler::AwesomeHandler.new
start_handlers << example_start_handler
report_handlers << example_handler
exception_handlers << example_handler