
module NeverBounce; module API
  # Base class for all errors.
  # @abstract
  class Error < StandardError; end

  # Incorrect attribute usage.
  class AttributeError < Error; end

  # Data format errors happening in our land.
  class FormatError < Error; end

  # Something went wrong with the request.
  class RequestError < Error; end
end; end

#
# Implementation notes:
#
# * None of these exceptions should be suppressed in end-user script.
#   Either they must be handled or they should crash the end-user script with a full backtrace.
