
require "never_bounce/api/response/container"

module NeverBounce; module API; module Response; module Feature
  # Common traits for message/container of the job status.
  # @see InstanceMethods
  module JobStatusFields
    require_relative "job_status_fields/total"

    # @param owner [Class]
    # @return [nil]
    def self.load(owner)
      # Validate owner, or calls to `oattr` will fail.
      raise ArgumentError, "Class #{owner} is not an ancestor of Response::Container" if not owner < Response::Container

      return if owner < InstanceMethods
      owner.send(:include, InstanceMethods)

      owner.class_eval do
        oattr :id, :scalar, type: :integer

        oattr :job_status, :scalar

        oattr :bounce_estimate, :scalar, type: :float
        oattr :filename, :scalar
        oattr :percent_complete, :scalar, type: :float

        oattr :total, :writer

        oattr :created_at, :scalar
        oattr :finished_at, :scalar
        oattr :started_at, :scalar
        oattr :failure_reason, :scalar
      end
    end

    # @!attribute id
    #   @return [Integer]
    # @!attribute job_status
    #   @return [String]
    # @!attribute bounce_estimate
    #   @return [Float]
    # @!attribute filename
    #   @return [String]
    # @!attribute percent_complete
    #   @return [Integer]
    # @!attribute total
    #   @return [Total]
    # @!attribute created_at
    #   @return [String]
    # @!attribute finished_at
    #   @return [String]
    # @!attribute started_at
    #   @return [String]
    module InstanceMethods
      def total
        @total ||= Total.new(body_hash: body_hash.fetch("total"))
      end
    end
  end
end; end; end; end

#
# Implementation notes:
#
# * (!) No means discovered to tell YARD that class A inherits methods from here.
#   Thus, we use a regular `@see` in those using this and other features.
# * YARD can't read `@!attribute` from inside `class_eval`, just ignores the comments.
# * YARD sorts all attributes alphabetically, we maintain our order, which is logical+alpha.
