if StopFile.stop_file_exists?
  Chef::Log.fatal("Stop file exists!")
  exit 1
else
  Chef::Log.warn("No stop file. Carrying on as normal.")
end