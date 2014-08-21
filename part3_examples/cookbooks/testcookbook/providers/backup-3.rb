require 'zlib'

def whyrun_supported?
  true
end

def load_current_resource
# Instantiate and populate our @current_resource object
  @current_resource = Chef::Resource::TestcookbookBackup.new(new_resource.name)
  @current_resource.backup_file(new_resource.backup_file)
end

action :compress do
  # Check if the file to back up already exists
  if ::File.exists?(current_resource.name)
    # If the backup file exists, calculate its age
    if ::File.exists?(current_resource.backup_file)
      backup_file_age_hours = (Time.now -
          ::File.mtime(current_resource.backup_file))/60/60
    end

    # if the backup file doesn't exist or is over 24 hours old
    if !::File.exists?(current_resource.backup_file) || backup_file_age_hours > 24

      # Wrap changing logic in converge_by so it works in why-run mode
      converge_by("Create backup file #{ new_resource.backup_file }") do
        # Compress the specified file with the specified name
        Chef::Log.info("Compressing #{new_resource.name}...")
        Zlib::GzipWriter.open(new_resource.backup_file) do |gz|
          gz.write IO.binread(new_resource.name)
        end
      end

      # Indicate to chef that we updated new_resource because we changed the node
      new_resource.updated_by_last_action(true)
    else
      Chef::Log.warn("Backup file #{new_resource.backup_file} is only " +
                         " #{backup_file_age_hours.round(2)} hours old. (Action will be skipped).")
    end
  else
    Chef::Log.warn("Can't find #{new_resource.name} to back up. " +
                       " (Action will be skipped).")
  end
end

action :extract do
  # If the backup file we asked for exists
  if ::File.exists?(current_resource.backup_file)

    # Unless the destination file already exists
    unless ::File.exists?(current_resource.name)

      # Wrap changing logic in converge_by so it works in why-run mode
      converge_by("Extract backup file #{ new_resource.backup_file }") do
        # Extract the backup file to the specified file
        Chef::Log.info("Extracting #{new_resource.backup_file}...")
        ::File.open(current_resource.backup_file) do |f|
          gz = Zlib::GzipReader.new(f)
          ::File.open(current_resource.name, 'w') { |file| file.write(gz.read) }
          gz.close
        end
      end

      # Indicate to chef that we updated new_resource because we changed the node
      new_resource.updated_by_last_action(true)
    else
      Chef::Log.warn("Destination file #{new_resource.name} " +
                         "already exists. (Action will be skipped).")
    end
  else
    Chef::Log.warn("Can't find backup file #{new_resource.backup_file} " +
                       "to extract. (Action will be skipped).")
  end
end