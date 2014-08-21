verify_api_cert true
require "/tmp/part2_examples/awesome_start_handler.rb"
require "/tmp/part2_examples/awesome_report_handler.rb" # ADD
example_start_handler = Chef::Handler::AwesomeStartHandler.new
example_report_handler = Chef::Handler::AwesomeReportHandler.new # ADD
start_handlers << example_start_handler
report_handlers << example_report_handler # ADD