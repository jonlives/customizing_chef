require 'chef/formatters/base'
class Chef
  module Formatters
    class Awesome < Formatters::Base
      cli_name(:awesome)
    end
  end
end