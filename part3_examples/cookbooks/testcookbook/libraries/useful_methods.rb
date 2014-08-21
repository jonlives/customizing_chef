module UsefulMethods

  def stop_file_exists?
    ::File.exists?("/tmp/stop_chef")
  end
end