
module NeverBounce; module API; module Feature
  # @see InstanceMethods#igetset
  module Igetset
    # @param owner [Class]
    # @return [nil]
    def self.load(owner)
      return if owner < InstanceMethods
      owner.send(:include, InstanceMethods)
    end

    module InstanceMethods
      private

      # Get/set an OTF instance variable of any type.
      #
      # Ruby's <tt>||=</tt> works nicely with object instances, but requires special bulky treatment for <tt>nil</tt> and <tt>false</tt>.
      # For example, this will cause a hidden glitch since <tt>==</tt> can evaluate to <tt>false</tt>:
      #
      #   @is_verbose ||= begin
      #     # This clause will be evaluated *every time* if its value is `false`.
      #     ENV["VERBOSE"] == "y"
      #   end
      #
      # There's a number of solutions to this problem, all of which involve calling <tt>instance_variable_*</tt> a few times per attribute accessor.
      #
      # <tt>igetset</tt> does this job for you. All you have to do is specify a block to compute the value.
      #
      #   igetset(:is_verbose) { ENV["VERBOSE"] == "y" }
      #
      # See source for details.
      def igetset(name, &compute)
        if instance_variable_defined?(k = "@#{name}")
          instance_variable_get(k)
        else
          instance_variable_set(k, compute.call)
        end
      end
    end
  end
end; end; end
