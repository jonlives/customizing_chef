# Define our module called 'Awesome'
module AwesomeModule
# Define a method called add
  def add(a,b)
# Return parameter a added to parameter b
    a+b
  end
end
# Now define our class called 'AwesomeClass'
class AwesomeClass
# Include methods defined in the module Awesome in this class
  include AwesomeModule
  attr_accessor :a, :b
  def initialize(a,b)
    @a = a
    @b = b
  end
  def add_numbers
# Call the add method from the Awesome module
    add(@a,@b)
  end
end
awesome_class = AwesomeClass.new(1,2)
puts "Result is #{awesome_class.add_numbers}"