def whyrun_supported?
  true
end

action :prepare do

  directory new_resource.working_dir do
    action :create
    recursive true
  end

  template new_resource.config_file do
    source 'awesomeator.conf.erb'
    variables({
                  :working_dir => new_resource.working_dir
              })
  end

  new_resource.updated_by_last_action(true)
end

action :cleanup do

  file new_resource.config_file do
    action :delete
  end

  directory new_resource.working_dir do
    action :delete
    recursive true
  end

  new_resource.updated_by_last_action(true)
end