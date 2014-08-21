Ohai.plugin(:Example2) do
  provides "awesome"
# Method to initialize object for our attribute
  def create_objects
# Create a new "Mash" object and assign it to "awesome"
    awesome Mash.new
  end
# Collect data block with symbol :default
  collect_data(:default) do
# Call the create_objects method to initialize our "awesome" attribute
    create_objects
# Assign the value 100 to the :level key of awesome
    awesome[:level] = 100
# Assign the value "Sriracha" to the :sauce key of awesome
    awesome[:sauce] = "Sriracha"
  end
# Collect data block with symbol :windows
  collect_data(:windows) do
# Call the create_objects method to initialize our "awesome" attribute
    create_objects
# Assign the value 101 to the :level key of awesome
    awesome[:level] = 101
# Assign the value "Cholula" to the :sauce key of awesome
    awesome[:sauce] = "Cholula"
  end
end