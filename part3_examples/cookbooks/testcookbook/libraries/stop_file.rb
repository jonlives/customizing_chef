class Chef::Recipe::StopFile

  def self.stop_file_exists?
    ::File.exists?("/tmp/stop_chef")
  end
end