class Awesome
  def break_stuff
    raise "Whoa, this is broken!"
  end
end

foo = Awesome.new
begin
  foo.break_stuff # This will throw an exception
rescue
  puts "Looks like there was an exception!" # But this will handle it!
end