
require "httparty"

require "never_bounce/api/feature/basic_initialize"
require "never_bounce/api/feature/igetset"
require "never_bounce/api/feature/require_attr"

module NeverBounce; module API
  # Single request-response session (server dialog).
  # @see API::Feature::BasicInitialize
  # @see API::Feature::Igetset
  # @see API::Feature::RequireAttr
  class Session
    API::Feature::BasicInitialize.load(self)
    API::Feature::Igetset.load(self)
    API::Feature::RequireAttr.load(self)

    attr_writer :httparty, :response, :robj_hash_preview, :robj_klass_and_attrs, :server_content_type, :server_obj, :server_ok, :server_raw

    # An instance of <tt>Request::Base</tt> successor.
    # @return [Object]
    attr_accessor :request

    # HTTParty module. Default is <tt>HTTParty</tt>.
    # @!attribute httparty
    # @return [Module]
    def httparty
      @httparty ||= HTTParty
    end

    # Meaningful response object.
    # @!attribute response
    # @return [Response::Message]
    # @return [Response::ErrorMessage]
    def response
      @response ||= begin
        klass, attrs = require_attr(:robj_klass_and_attrs)
        klass.new(attrs)
      end
    end

    # Render response object class and constructor attributes based on peeking in the data.
    # @!attribute robj_klass_and_attrs
    # @return [Array<Class,Hash>]
    def robj_klass_and_attrs
      @robj_klass_and_attrs ||= begin
        if (h = robj_hash_preview).is_a? Hash
          # Determine response class based on API convention.
          begin
            [
              h.fetch("status") == "success" ? request.class.response_klass : Response::ErrorMessage,
              body_hash: robj_hash_preview,
            ]
          rescue KeyError
            raise FormatError, "Key 'status' not found: #{h.inspect}"
          end
        elsif robj_hash_preview == false
          # Let response class handle it on its own.
          [
            request.class.response_klass,
            raw: server_raw,
          ]
        else
          raise AttributeError, "Unknown `robj_hash_preview`: #{robj_hash_preview.inspect}"
        end
      end
    end

    # Response body, opportunistically JSON-parsed based on <tt>server_content_type</tt>.
    # @return [Hash]
    # @return [false] If <tt>server_content_type</tt> isn't a JSON.
    def robj_hash_preview
      igetset(:robj_hash_preview) do
        case require_attr(:server_content_type)
        when "application/json"
          begin
            JSON.parse(server_raw)
          rescue JSON::ParserError => e
            raise FormatError, "#{e.class}: #{e.message}"
          end
        else
          false
        end
      end
    end

    # Server response code. Default is <tt>server_obj.code</tt>.
    # @!attribute server_code
    # @return [Integer]
    def server_code
      @server_code ||= require_attr(:server_obj).code
    end

    # Server response content type. Default is <tt>server_obj.content_type</tt>.
    # @!attribute server_content_type
    # @return [String]
    def server_content_type
      @server_content_type ||= begin
        require_attr(:server_obj).content_type
      end
    end

    # Make a request, return server response object from HTTParty.
    # @return [Object] An <tt>HTTParty::Response</tt>.
    def server_obj
      @server_obj ||= begin
        httparty.send *require_attr(:request).to_httparty
      end
    end

    # <tt>true</tt> if response is an OK response.
    # @!attribute server_ok
    # @return [Boolean]
    def server_ok
      igetset(:server_ok) { require_attr(:server_obj).ok? }
    end

    alias_method :server_ok?, :server_ok

    # Raw server response body. Default is <tt>server_obj.body</tt>.
    # @!attribute server_raw
    # @return [String]
    def server_raw
      @server_raw ||= begin
        raise RequestError, "Code not OK: #{server_code}" if not server_ok?
        server_obj.body
      end
    end
  end
end; end

#
# Implementation notes:
#
# * `server_*` methods deal with stage 1, received directly from the server via HTTParty.
#   `robj_*` methods deal with stage 2, converting raw data into response object.
#   Everything `response*` relates to meaningful response object.
# * Response classes can natively parse their raw content to JSON, and that is right.
#   BUT we also use JSON parsing here, for the purpose of detecting success/error response class.
# * We inherit response "OK?" condition from HTTParty, which inherits it from `net/http`.
#   `ok?` maps to `Net::HTTPOK` class equality check.
