def whyrun_supported?
  true
end

def load_current_resource
# Instantiate and populate our @current_resource object
  @current_resource = Chef::Resource::TestcookbookBackup.new(new_resource.name)
  @current_resource.backup_file(new_resource.backup_file)
end

action :compress do
end

action :extract do
end