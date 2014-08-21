class Awesome
  def break_stuff
    raise "Whoa, this is broken!"
  end
end

foo = Awesome.new
foo.break_stuff # This will throw a RuntimeError