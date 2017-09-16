
require "never_bounce/api/response/feature/job_status_fields"

require_relative "success_message"

module NeverBounce; module API; module Response
  # @see Feature::JobStatusFields
  class JobsStatus < SuccessMessage
    Response::Feature::JobStatusFields.load(self)
  end
end; end; end
