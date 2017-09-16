
describe NeverBounce::API::Feature::Oattrs do
  let(:parent_klass) do
    feature = described_class

    Class.new do
      feature.load(self)

      oattr :parent_a, :writer

      def parent_a
        @parent_a ||= "parent_a"
      end
    end
  end

  let(:klass) do
    feature = described_class

    Class.new(parent_klass) do
      feature.load(self)

      oattr :a, :writer
      oattr :b, :custom

      def a
        @a ||= "a"
      end

      def b
        @b ||= "b"
      end

      def b=(value)
        @b = value
      end
    end
  end

  describe "attribute access" do
    include_dir_context __dir__

    it "generally works" do
      r = parent_klass.new
      expect(r.parent_a).to eq "parent_a"
      r.parent_a = "yo"
      expect(r.parent_a).to eq "yo"

      r = klass.new
      expect(r.b).to eq "b"
      r.b = "yo"
      expect(r.b).to eq "yo"
    end
  end

  describe ".attrs" do
    it "generally works" do
      expect(parent_klass.oattrs).to eq [:parent_a]
      expect(klass.oattrs).to eq [:parent_a, :a, :b]
    end
  end

  describe "#touch" do
    it "generally works" do
      r = klass.new
      expect(r.touch).to eq r
      expect(r.inspect).to include '@parent_a="parent_a"'
      expect(r.inspect).to include '@a="a"'
      expect(r.inspect).to include '@b="b"'
    end
  end
end
