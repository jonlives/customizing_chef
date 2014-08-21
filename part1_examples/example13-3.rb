class Awesome
  def break_stuff
    raise "Whoa, this is broken!"
  end
end

foo = Awesome.new
begin
  foo.break_stuff # This will throw an exception
rescue => ex # Let's name our exception object and use it
  puts "Exception of class #{ex.class} thrown with message #{ex.message}"
end