define :awesomeator_prepare,
       :working_dir => '/tmp/awesomeator',
       :config_file => '/etc/awesomeator.conf' do
  directory params[:working_dir] do
    action :create
    recursive true
  end
  template params[:config_file] do
    source 'awesomeator.conf.erb'
    variables({
                  :working_dir => params[:working_dir]
              })
  end
end