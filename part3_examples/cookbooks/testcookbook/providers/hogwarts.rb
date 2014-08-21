def whyrun_supported?
  true
end

action :magic do
  Chef::Log.warn("You're a wizard, Harry!")
end