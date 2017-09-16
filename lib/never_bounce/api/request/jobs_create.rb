
require_relative "base"

module NeverBounce; module API; module Request
  class JobsCreate < Base
    # @return [Boolean]
    attr_accessor :auto_parse

    # @return [Boolean]
    attr_accessor :auto_start

    # @return [String]
    attr_accessor :filename

    # Input specification.
    # @return [String] URL if <tt>input_location</tt> is <tt>"remote".
    # @return [Array<Array<email, name>>] Structure if <tt>input_location</tt> is "supplied".
    attr_accessor :input

    # @return [String]
    attr_accessor :input_location

    # @return [Boolean]
    attr_accessor :run_sample

    # @return [Symbol]
    def self.http_method
      :post
    end

    # @return [String]
    def self.path
      "jobs/create"
    end

    # @return [Response::JobsCreate]
    def self.response_klass
      Response::JobsCreate
    end

    # Return a ready-to-merge mode attributes hash.
    # @return [Hash]
    def mode_h
      @mode_h ||= {}.tap do |_|
        unless (v = auto_start).nil?
          _[:auto_start] = v
        end

        unless (v = auto_parse).nil?
          _[:auto_parse] = v
        end

        unless (v = run_sample).nil?
          _[:run_sample] = v
        end
      end
    end

    # @return [Hash]
    def to_h
      input = require_attr(:input)
      input_location = require_attr(:input_location)

      # Validate `input_location` and `input`.

      if not ["remote_url", "supplied"].include? input_location
        raise AttributeError, "Unknown `input_location`: #{input_location.inspect}"
      end

      if input_location == "supplied"
        raise AttributeError, "Invalid `input` for `input_location` == #{input_location.inspect}: #{input.inspect}" if not input.is_a? Array

        # Skim through elements of `input`, raise if invalid structure detected, with details.
        input.each do |elem|
          em = [AttributeError, "Invalid `input` element: #{elem.inspect}"]
          raise *em unless elem.is_a? Array
          raise *em unless elem.map(&:class) == [String, String]
        end
      end

      # Result.
      {
        input: input,
        input_location: input_location,
        filename: require_attr(:filename),
        key: require_attr(:api_key),
      }.merge(mode_h)
    end
  end
end; end; end
