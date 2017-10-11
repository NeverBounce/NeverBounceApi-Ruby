require_relative "success_message"

module NeverBounce; module API; module Response;
  class POEConfirm < SuccessMessage
    # @!attribute token_confirmed
    #   @return [Bool]
    oattr :token_confirmed, :scalar
  end
end; end; end
