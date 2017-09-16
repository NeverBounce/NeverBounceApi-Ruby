
#
# SimpleCov. See https://github.com/colszowka/simplecov.
#
# * IMPORTANT! This file must be required by hand BEFORE all others.
#   Other than that it can be considered
#

begin
  require "simplecov"
  puts "NOTE: SimpleCov starting"
  SimpleCov.start do
    # Add configuration once required.
    # See https://github.com/colszowka/simplecov#configuring-simplecov.
  end
rescue LoadError
  # This is mostly a normal case, don't print anything.
end
