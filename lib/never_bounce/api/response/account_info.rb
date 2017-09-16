
require "never_bounce/api/response/credits_info/monthly"
require "never_bounce/api/response/credits_info/paid"

require_relative "success_message"

module NeverBounce; module API; module Response
  class AccountInfo < SuccessMessage
    require_relative "account_info/job_counts"

    # @!attribute [rw]
    oattr :credits_info, :writer

    # @!attribute [rw]
    oattr :job_counts, :writer

    # @return [CreditsInfo::Monthly]
    # @return [CreditsInfo::Paid]
    def credits_info
      @credits_info ||= begin
        h = body_hash.fetch("credits_info")
        klass = if h.has_key? "monthly_api_usage"
          CreditsInfo::Monthly
        elsif h.has_key? "paid_credits_remaining"
          CreditsInfo::Paid
        else
          raise "Unknown `credits_info`: #{h.inspect}"
        end

        klass.new(h)
      end
    end

    # @return [JobCounts]
    def job_counts
      @job_counts ||= JobCounts.new(body_hash: body_hash.fetch("job_counts"))
    end
  end
end; end; end
