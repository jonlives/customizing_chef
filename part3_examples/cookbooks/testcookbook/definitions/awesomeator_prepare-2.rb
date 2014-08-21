define :awesomeator_prepare,
       :working_dir => '/tmp/awesomeator',
       :config_file => '/etc/awesomeator.conf' do
  puts "working_dir = #{params[:working_dir]}"
  puts "config_file = #{params[:config_file]}"
end