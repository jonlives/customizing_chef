# Require the two stdlib classes we need,
# which aren't included by default
require "net/http"
require "uri"
# The module namespace our classes will live in
module Examples
# Custom exception class
  class InvalidURLError < StandardError
  end
# Our main class definition
  class HTTPRequester
# Custom getter method for @url class instance variable
    def url
# The to_s method returns the String representation
# of the @url variable
      @url.to_s
    end
# Custom setter method for @url class instance variable
# because we're parsing the url parameter before assigning
# to @url
    def url=(url)
      begin
        @url = URI.parse(url)
# rescue URI::InvalidURIError exception that occurs
# when we try to parse an invalid URL
      rescue URI::InvalidURIError
# Raise a custom exception with a more friendly message
        raise InvalidURLError.new("#{url} was not a valid URL.")
      end
    end
# initialize method
    def initialize(url)
# Call the setter method for the url attribute to set it
# to the value passed to this method
      self.url = url
# When we're sure our URL is valid, create a Net::HTTP object
# and assign it to the @http_object class instance variable
      @http_object = Net::HTTP.new(@url.host, @url.port)
    end
# Class method to make a GET request
    def get_request
# Use our @http_object object's request method to call the
# Net::HTTP::Get class and return the resulting response object
      @http_object.request(Net::HTTP::Get.new(@url.request_uri))
    end
  end
end
# Let's try out our class with a valid URL
# Initialize our object; note that we're specifying Module::Class
puts "Initializing Example::HTTPRequester for http://www.oreilly.com"
http_requestor = Examples::HTTPRequester.new("http://www.oreilly.com")
puts "Performing GET request"
# Here we're calling the .code method of the Net::HTTP::Request
# object that is returned by the get_request method
puts "Response code was #{http_requestor.get_request.code}"
# puts a blank line for spacing
puts ""
# Let's try out our class with an *invalid* URL
# Initialize our object; note that we're specifying Module::Class
puts "Initializing Examples::HTTPRequester for 123"
http_requestor = Examples::HTTPRequester.new(123)
puts "Performing GET request"
# Here we're calling the .code method of the Net::HTTP::Request
# object that is returned by the get_request method
puts "Response code was #{http_requestor.get_request.code}"
