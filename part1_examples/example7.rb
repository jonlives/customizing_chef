module AwesomeInc
  class Awesome
    attr_accessor :awesome_level
    def initialize(awesome_level)
      @awesome_level = awesome_level
    end
  end
end
foo = AwesomeInc::Awesome.new(10)
bar = AwesomeInc::Awesome.new(20)
puts foo.awesome_level
puts bar.awesome_level