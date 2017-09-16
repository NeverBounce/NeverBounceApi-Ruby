
require_relative "container"

module NeverBounce; module API; module Response
  # A response message from the server.
  # A top-level container with a few extra features.
  class Message < Container
    # <tt>true</tt> if this an error message.
    # @see #success?
    def error?
      !success?
    end

    # An alias to {#success?}.
    def ok?
      success?
    end

    # <tt>true</tt> if this is a success message.
    # @abstract
    def success?
      raise NotImplementedError, "Redefine `success?` in your class: #{self.class}"
    end
  end
end; end; end

#
# Implementation notes:
#
# * `ErrorMessage` and `SuccessMessage` are ancestors of this class.
#   I don't go for more correct `Message::Error` since I want to keep this sub-hierarchy flat.
#   There aren't going to be a big family of `*Message`, so simplified suffix grouping should be okay.
