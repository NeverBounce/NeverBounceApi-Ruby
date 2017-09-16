
RSpec.configure do |config|
  config.extend Module.new {
    # Include hierarchical contexts from <tt>spec/</tt> up to spec root.
    #
    #   describe Something do
    #     include_dir_context __dir__
    #     ...
    def include_dir_context(dir)
      spec_root = File.expand_path("..", __dir__)
      d, steps = dir, []
      while d.size >= spec_root.size
        steps << d
        d = File.join(File.split(d)[0..-2])
      end

      steps.reverse.each do |d|
        begin; include_context d; rescue ArgumentError; end
      end
    end
  } # config.extend
end
