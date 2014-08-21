require 'chef/formatters/minimal'
class Chef
  module Formatters
    class Awesome < Formatters::Minimal
      cli_name(:awesome)
    end
  end
end