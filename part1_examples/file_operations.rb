# The module namespace our classes will live in
module Examples
# Custom exception class
  class FileCreationError < StandardError
  end
# Our main class definition
  class FileLogger
# attr_accessor method for log_file class instance variable
    attr_accessor :log_file
# initialize method
    def initialize(log_file)
# Set @logfile class instance variable to value of parameter
      @log_file = log_file
# Wrap initial file creation in a begin block
      begin
# Try creating the file in "write" mode
        File.new(@log_file, "w")
# Rescue Errno::EACCES exception that occurs
# when file can't be created due to insufficient permissions
      rescue Errno::EACCES
# Raise a custom exception with a more friendly message
# (split over two lines below because of space constraints)
        raise FileCreationError.new("#{@log_file} could not be created. "+
                                        "Please check the specified directory is writeable by your user.")
      end
    end
# methods of our FileLogger object
    def file_writable?
# Return true if our created file is writeable, false if not
      File.writable?(@log_file)
    end
    def write_to_log(message)
# Open our file in "append" mode and write the message string to it
# This {} syntax in Ruby allows a do...end block to be written on
# one line
      File.open(@log_file, 'a') {|f| f.write(message) }
    end
    def clear_log
# Clear the contents of the file
      File.truncate(@log_file, 0)
    end
  end
end
# Try creating and writing to a file we should have permissions to
# Initialize our object; note that we're specifying Module::Class
puts "Creating log file /tmp/testfile"
file_logger = Examples::FileLogger.new("/tmp/testfile")
puts "file writable: #{file_logger.file_writable?}"
puts "Writing to log file"
file_logger.write_to_log ("Test log message")
puts "Clearing log file"
file_logger.clear_log
# puts a blank line for spacing
puts ""
# Try creating and writing to a file we should *not* have permissions to
# Initialize our object; note that we're specifying Module::Class
puts "Creating log file /usr/testfile"
file_logger = Examples::FileLogger.new("/usr/testfile")
puts "file writeable: #{file_logger.file_writeable?}"
puts "Writing to log file"
file_logger.write_to_log ("Test log message")
puts "Clearing log file"
file_logger.clear_log