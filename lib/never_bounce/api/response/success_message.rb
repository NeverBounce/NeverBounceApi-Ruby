
require_relative "status_message"

module NeverBounce; module API; module Response
  # A meaningful (success) response from the server.
  class SuccessMessage < StatusMessage
    # @return [true]
    def success?
      true
    end
  end
end; end; end
