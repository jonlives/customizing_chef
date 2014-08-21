
require 'fileutils'

class Chef
  class Provider
    class AwesomeBackup < Chef::Provider

      def whyrun_supported?
        true
      end

      def load_current_resource
        @current_resource = Chef::Resource::AwesomeBackup.new(new_resource.name)
        @current_resource.backup_file(new_resource.backup_file)
        @current_resource.cleanup(new_resource.cleanup)
        @current_resource.num_backups(new_resource.num_backups)
      end

      # Define methods for our actions
      def action_compress
        # Check if the file to back up already exists
        if ::File.exists?(current_resource.name)

            # If the backup file exists, calculate its age
            if ::File.exists?(current_resource.backup_file)
              backup_file_age_hours = (Time.now -
                  ::File.mtime(current_resource.backup_file))/60/60
            end

          # If the backup file is over 24 hours old (which also means 
          # that it exists)
          if !::File.exists?(current_resource.backup_file) ||
              backup_file_age_hours > 24

            # Check if the number of backups we want to keep is > 0
            # before trying to rotate
            if @current_resource.num_backups < 0
              # Wrap changing logic in converge_by so it works in why-run mode
              converge_by("Rotate backup files "+
                              "(retaining maximum #{@current_resource.num_backups})") do
                  # Rotate existing backup files
                  (@current_resource.num_backups - 1).downto(1).each do |f|
                    if ::File.exists?("#{current_resource.backup_file}-#{f}")
                      ::FileUtils.mv("#{current_resource.backup_file}-#{f}",
                                     "#{current_resource.backup_file}-#{f+1}")
                    end
                    if ::File.exists?(current_resource.backup_file)
                      # Rotate current backup file
                      ::FileUtils.mv(current_resource.backup_file,
                                     "#{current_resource.backup_file}-1")
                    end
                  end
              end
            end

            # Wrap changing logic in converge_by so it works in why-run mode
            converge_by("Create backup file #{ new_resource.backup_file }") do
              # Compress the specified file with the specified name
              Chef::Log.info("Compressing #{new_resource.name}...")
              Zlib::GzipWriter.open(new_resource.backup_file) do |gz|
                gz.write IO.binread(new_resource.name)
              end
            end

            # Indicate to Chef that we updated new_resource because we 
            # changed the node
            new_resource.updated_by_last_action(true)
          else
            Chef::Log.warn("Backup file #{new_resource.backup_file} is only " +
                               " #{backup_file_age_hours.round(2)} hours old.
              (Action will be skipped).")
          end
        else
          Chef::Log.warn("Can't find #{new_resource.name} to back up. " +
                             " (Action will be skipped).")
        end
      end

      def action_extract
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
                ::File.open(current_resource.name,
                            'w') do |file|
                  file.write(gz.read)
                end
              end
            end

              # If the current_resource.cleanup attribute is true
              if current_resource.cleanup
                # Wrap changing logic in converge_by so it works in why-run mode
                converge_by("Delete backup file #{ new_resource.backup_file }") do
                  # Delete the backup file
                  ::File.delete(new_resource.backup_file)
                end
              end

              # Indicate to Chef that we updated new_resource because we
              # changed the node
              new_resource.updated_by_last_action(true)

          else
              Chef::Log.warn("Destination file #{new_resource.name} " +
                               "already exists.  (Action will be skipped).")
          end
        else
          Chef::Log.warn("Can't find backup file #{new_resource.backup_file} " +
                           "to extract.  (Action will be skipped).")
        end
      end
    end
  end
end