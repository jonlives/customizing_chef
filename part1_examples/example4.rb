class Awesome
  def initialize(awesome_level)
    @awesome_level = awesome_level
  end
  def awesome_level # getter method for awesome_level
    @awesome_level
  end
  def awesome_level=(new_awesome_level) # setter method for awesome_level
    @awesome_level = new_awesome_level
  end
end
awesome_sauce = Awesome.new(100)
puts "awesome_sauce has an awesome_level of #{awesome_sauce.awesome_level}"
awesome_sauce.awesome_level = 99
puts "awesome_sauce has an awesome_level of #{awesome_sauce.awesome_level}"