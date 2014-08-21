require 'chef/formatters/base'
class Chef
  module Formatters
    class Awesome < Formatters::Base
      cli_name(:awesome)
      def synchronized_cookbook(cookbook_name)
        puts "\nCookbook #{cookbook_name} synchronized.\n"
      end
      def resource_up_to_date(resource, action)
        puts "#{resource.cookbook_name}::#{resource.recipe_name}"
        puts " #{resource}:\n Up to date, skipped action #{action}\n"
      end
      def resource_updated(resource, action)
        puts "#{resource.cookbook_name}::#{resource.recipe_name}"
        puts " #{resource}:\n Updated, performed action #{action}\n"
      end
    end
  end
end