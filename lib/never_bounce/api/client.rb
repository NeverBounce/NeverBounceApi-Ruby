
require "never_bounce/api/error"
require "never_bounce/api/feature/basic_initialize"
require "never_bounce/api/feature/require_attr"

module NeverBounce; module API
  # API client.
  #
  #   client = NeverBounce::API::Client.new(api_key: "api_key")
  #
  #   response = client.account_info
  #   # => #<NeverBounce::API::Response::AccountInfo> or
  #   # => #<NeverBounce::API::ErrorMessage>
  #
  #   response = client.single_check(credits_info: true, email: "support@neverbounce.com", timeout: 3)
  #   # => #<NeverBounce::API::Response::JobsDownload> or
  #   # => #<NeverBounce::API::ErrorMessage>
  #
  #   response = client.jobs_search(page: 1, per_page: 10)
  #   # => #<NeverBounce::API::Response::JobsSearch> or
  #   # => #<NeverBounce::API::ErrorMessage>
  #
  #   # ...
  #
  # @see #account_info
  # @see #jobs_create
  # @see #jobs_delete
  # @see #jobs_download
  # @see #jobs_parse
  # @see #jobs_results
  # @see #jobs_search
  # @see #jobs_start
  # @see #jobs_status
  # @see #single_check
  # @see https://developers.neverbounce.com/v4.0/reference
  class Client
    Feature::BasicInitialize.load(self)
    Feature::RequireAttr.load(self)

    attr_writer :api_key, :api_version

    # API key.
    # @return [String]
    def api_key
      @api_key or raise AttributeError, "Attribute must be set: api_key"
    end

    # API version.
    # @return [String]
    def api_version
      @api_version
    end

    #--------------------------------------- Misc

    # Wrap request in a session, return response.
    # @param request [Object] An instance of {Request::Base} successor.
    # @return [Object] Result of {Session#response}.
    def response_to(request)
      Session.new(request: request).response
    end
    private :response_to

    #--------------------------------------- Requests

    # Make an <tt>account/info</tt> request.
    # @return [Response::AccountInfo]
    # @return [Response::ErrorMessage]
    # @raise [API::Error]
    # @raise [StandardError]
    # @see Request::AccountInfo
    # @see https://developers.neverbounce.com/v4.0/reference#account-info
    def account_info
      response_to(Request::AccountInfo.new({
        api_key: api_key,
        api_version: api_version,
      }))
    end

    # Make a <tt>jobs/create</tt> request.
    # @param auto_parse [Boolean]
    # @param auto_start [Boolean]
    # @param filename [Boolean] Default is <tt>"YYYYMMDD-HHMMSS.csv"</tt> based on current time.
    # @param remote_input [String] E.g. <tt>"http://isp.com/emails.csv"</tt>.
    # @param run_sample [Boolean]
    # @param supplied_input [Array<Array<email, name>>] E.g. <tt>[["alice@isp.com", "Alice Roberts"], ["bob.smith@gmail.com", "Bob Smith"]]</tt>.
    # @return [Response::JobsCreate]
    # @return [Response::ErrorMessage]
    # @raise [API::Error]
    # @raise [StandardError]
    # @see Request::JobsCreate
    # @see https://developers.neverbounce.com/v4.0/reference#jobs-create
    def jobs_create(auto_parse: false, auto_start: false, filename: nil, remote_input: nil, run_sample: false, supplied_input: nil, historical: nil)
      raise ArgumentError, "`remote_input` and `supplied_input` can't both be given" if remote_input && supplied_input

      input_location = if (v = remote_input)
        # NOTE: Logical order: type, then value.
        input = v
        "remote_url"
      elsif (v = supplied_input)
        input = v
        "supplied"
      else
        # NOTE: Not exactly sure what to raise here. From procedure standpoint missing argument is an `ArgumentError`.
        raise ArgumentError, "Input not given, use `remote_input` or `supplied_input`"
      end

      filename ||= Time.now.strftime("%Y%m%d-%H%M%S.csv")

      response_to(API::Request::JobsCreate.new({
        api_key: api_key,
        api_version: api_version,
        auto_parse: auto_parse,
        auto_start: auto_start,
        filename: filename,
        input: input,
        input_location: input_location,
        run_sample: run_sample,
        historical: historical,
      }))
    end

    # Make a <tt>jobs/delete</tt> request.
    # @param job_id [Integer]
    # @return [Response::JobsDelete]
    # @return [Response::ErrorMessage]
    # @raise [API::Error]
    # @raise [StandardError]
    # @see Request::JobsDelete
    # @see https://developers.neverbounce.com/v4.0/reference#jobs-delete
    def jobs_delete(job_id: nil)
      response_to(Request::JobsDelete.new({
        api_key: api_key,
        api_version: api_version,
        job_id: job_id,
      }))
    end

    # Make a <tt>jobs/download</tt> request.
    # @param job_id [Integer]
    # @return [Response::JobsDownload]
    # @return [Response::ErrorMessage]
    # @raise [API::Error]
    # @raise [StandardError]
    # @see Request::JobsDownload
    # @see https://developers.neverbounce.com/v4.0/reference#jobs-download
    def jobs_download(job_id: nil)
      response_to(Request::JobsDownload.new({
        api_key: api_key,
        api_version: api_version,
        job_id: job_id,
      }))
    end

    # Make a <tt>jobs/parse</tt> request.
    # @param auto_start [Boolean]
    # @param job_id [Integer]
    # @return [Response::JobsParse]
    # @return [Response::ErrorMessage]
    # @raise [API::Error]
    # @raise [StandardError]
    # @see Request::JobsParse
    # @see https://developers.neverbounce.com/v4.0/reference#jobs-parse
    def jobs_parse(auto_start: nil, job_id: nil)
      response_to(Request::JobsParse.new({
        api_key: api_key,
        api_version: api_version,
        auto_start: auto_start,
        job_id: job_id,
      }))
    end

    # Make a <tt>jobs/results</tt> request.
    # @param job_id [Integer]
    # @param page [Integer]
    # @param per_page [Integer]
    # @return [Response::JobsResults]
    # @return [Response::ErrorMessage]
    # @raise [API::Error]
    # @raise [StandardError]
    # @see Request::JobsResults
    # @see https://developers.neverbounce.com/v4.0/reference#jobs-results
    def jobs_results(job_id: nil, page: 1, per_page: nil)
      response_to(Request::JobsResults.new({
        api_key: api_key,
        api_version: api_version,
        job_id: job_id,
        page: page,
        per_page: per_page,
      }))
    end

    # Make a <tt>jobs/search</tt> request.
    # @param job_id [Integer]
    # @param page [Integer]
    # @param per_page [Integer]
    # @return [Response::JobsSearch]
    # @return [Response::ErrorMessage]
    # @raise [API::Error]
    # @raise [StandardError]
    # @see Request::JobsSearch
    # @see https://developers.neverbounce.com/v4.0/reference#jobs-search
    def jobs_search(job_id: nil, page: 1, per_page: nil)
      response_to(Request::JobsSearch.new({
        api_key: api_key,
        api_version: api_version,
        job_id: job_id,
        page: page,
        per_page: per_page,
      }))
    end

    # Make a <tt>jobs/start</tt> request.
    # @param job_id [Integer]
    # @param run_sample [Boolean]
    # @return [Response::JobsResults]
    # @return [Response::ErrorMessage]
    # @raise [API::Error]
    # @raise [StandardError]
    # @see Request::JobsResults
    # @see https://developers.neverbounce.com/v4.0/reference#jobs-start
    def jobs_start(job_id: nil, run_sample: nil)
      response_to(Request::JobsStart.new({
        api_key: api_key,
        api_version: api_version,
        job_id: job_id,
        run_sample: run_sample,
      }))
    end

    # Make a <tt>jobs/status</tt> request.
    # @param job_id [Integer]
    # @return [Response::JobsStatus]
    # @return [Response::ErrorMessage]
    # @raise [API::Error]
    # @raise [StandardError]
    # @see Request::JobsStatus
    # @see https://developers.neverbounce.com/v4.0/reference#jobs-status
    def jobs_status(job_id: nil)
      response_to(Request::JobsStatus.new({
        api_key: api_key,
        api_version: api_version,
        job_id: job_id,
      }))
    end

    # Make a <tt>single/check</tt> request.
    # @param address_info [Boolean]
    # @param credits_info [Boolean]
    # @param email [String]
    # @param timeout [Integer]
    # @return [Response::SingleCheck]
    # @return [Response::ErrorMessage]
    # @raise [API::Error]
    # @raise [StandardError]
    # @see Request::SingleCheck
    # @see https://developers.neverbounce.com/v4.0/reference#single-check
    def single_check(address_info: nil, credits_info: nil, email: nil, timeout: nil, historical: nil)
      response_to(Request::SingleCheck.new({
        address_info: address_info,
        api_key: api_key,
        api_version: api_version,
        credits_info: credits_info,
        email: email,
        timeout: timeout,
        historical: historical,
      }))
    end

    # Make a <tt>poe/confirm</tt> request.
    # @param email [String]
    # @param transaction_id [String]
    # @param confirmation_token [String]
    # @param result [String]
    # @return [Response::POEConfirm]
    # @return [Response::ErrorMessage]
    # @raise [API::Error]
    # @raise [StandardError]
    # @see Request::POEConfirm
    # @see https://developers.neverbounce.com/v4.0/reference#poe-confirm
    def poe_confirm(email: nil, transaction_id: nil, confirmation_token: nil, result: nil)
      response_to(Request::POEConfirm.new({
        api_key: api_key,
        api_version: api_version,
        email: email,
        transaction_id: transaction_id,
        confirmation_token: confirmation_token,
        result: result,
      }))
    end
  end
end; end

#
# Implementation notes:
#
# * `api_key` is so common that we validate its presence in reader method rather than elsewhere.
#   Hence there isn't a `require_attr(:api_key)` anywhere.
#   `api_key` is Client's own business, hence the presence validation at this level.
