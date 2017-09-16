
require_relative "success_message"

module NeverBounce; module API; module Response
  class JobsParse < SuccessMessage
    # @!attribute queue_id
    #   @return [String]
    oattr :queue_id, :scalar
  end
end; end; end
