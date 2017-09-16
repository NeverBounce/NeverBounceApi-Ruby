
require "never_bounce/api/response/container"
require "never_bounce/api/response/feature/job_status_fields"

require_relative "../jobs_search"

module NeverBounce; module API; module Response; class JobsSearch
  # A single e-mail verification result.
  # @see Response::Feature::JobStatusFields
  class Result < Container
    Response::Feature::JobStatusFields.load(self)
  end
end; end; end; end
