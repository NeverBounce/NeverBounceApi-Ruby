
require_relative "status_message"

module NeverBounce; module API; module Response
  # A failure (error) response from the server.
  # @see https://developers.neverbounce.com/v4.0/reference#error-handling
  class ErrorMessage < StatusMessage
    # @!attribute message
    #   @return [String]
    oattr :message, :scalar

    # @return [false]
    def success?
      false
    end
  end
end; end; end
