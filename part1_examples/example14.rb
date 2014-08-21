class SuperSeriousProblem < Exception # Our new custom exception class
end
class Awesome
  def break_stuff
    raise SuperSeriousProblem.new("Whoa, this is broken!") # Raise our new exception type
  end
end
foo = Awesome.new
begin
  foo.break_stuff # This will throw a SuperSecretProblem exception
rescue SuperSeriousProblem => ex # Which we're now handling
  puts "SuperSeriousProblem: Something went really, really wrong."
end