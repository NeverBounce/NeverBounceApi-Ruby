
module NeverBounce; module API; module Feature
  # Provide the basic method <tt>#initialize</tt> to the owner class.
  # @see InstanceMethods#initialize
  module BasicInitialize
    # @param owner [Class]
    # @return [nil]
    def self.load(owner)
      return if owner < InstanceMethods
      owner.send(:include, InstanceMethods)
    end

    module InstanceMethods
      # See source for details.
      def initialize(attrs = {})
        attrs.each { |k, v| public_send("#{k}=", v) }
      end
    end
  end
end; end; end
