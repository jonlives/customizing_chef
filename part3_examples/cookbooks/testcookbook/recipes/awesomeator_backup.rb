testcookbook_backup "/etc/awesomeator.conf" do
  backup_file "/tmp/awesomeator.gz"
  action :compress
end