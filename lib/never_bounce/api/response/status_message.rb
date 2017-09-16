
require_relative "message"

module NeverBounce; module API; module Response
  # A message having <tt>status</tt> and <tt>execution_time</tt>.
  class StatusMessage < Message
    # @!attribute execution_time
    #   Request execution time in milliseconds.
    #   @return [Integer]
    oattr :execution_time, :scalar, type: :integer

    # @!attribute status
    #   Status mnemo as returned by the server.
    #   @return [String]
    oattr :status, :scalar
  end
end; end; end
