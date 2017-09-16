
require_relative "success_message"

module NeverBounce; module API; module Response
  class JobsCreate < SuccessMessage
    # @!attribute job_id
    #   @return [Integer]
    oattr :job_id, :scalar, type: :integer
  end
end; end; end
