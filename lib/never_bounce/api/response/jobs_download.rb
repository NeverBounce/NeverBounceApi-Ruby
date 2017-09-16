
require_relative "message"

module NeverBounce; module API; module Response
  # A response to <tt>jobs/download</tt>.
  # Body is an octet-stream, not a JSON structure.
  # @see https://developers.neverbounce.com/v4.0/reference#jobs-download
  class JobsDownload < Message
    # Always <tt>true</tt>.
    def success?
      true
    end
  end
end; end; end

#
# Implementation notes:
#
# * This class uses `body` in its literal form. All the rest basically JSON-parse it.
