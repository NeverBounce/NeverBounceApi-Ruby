
module NeverBounce; module API; module Feature
  # Eigenclass (singleton class)-based cache which allows to handle "hidden" instance variables.
  # @see InstanceMethods#_cache
  module Eigencache
    # @param owner [Class]
    # @return [nil]
    def self.load(owner)
      return if owner < InstanceMethods
      owner.send(:include, InstanceMethods)
    end

    module InstanceMethods
      # Hidden cache.
      #
      #   def body
      #     _cache[:body] ||= File.read("my-bulky-body.csv")
      #   end
      #
      #   def body=(v)
      #     _cache[:body] = v
      #   end
      #
      # @return [Hash]
      def _cache
        if eigen.instance_variable_defined?(k = :@cache)
          eigen.instance_variable_get(k)
        else
          eigen.instance_variable_set(k, {})
        end
      end

      #---------------------------------------
      private

      # Object's eigenclass (singleton class).
      # @return [Class]
      def eigen
        class << self; self; end
      end
    end
  end
end; end; end

#
# Implementation notes:
#
# * As of Ruby 2.1 `Object#singleton_class` is introduced. We use our own compatible implementation, `eigen`.
