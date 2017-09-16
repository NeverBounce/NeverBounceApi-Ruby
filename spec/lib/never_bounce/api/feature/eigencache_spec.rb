
describe NeverBounce::API::Feature::Eigencache do
  let(:klass) do
    feature = described_class

    Class.new do
      feature.load(self)

      def a
        _cache[:a] ||= "a"
      end

      def a=(value)
        _cache[:a] = value
      end
    end
  end

  it "generally works" do
    r = klass.new
    expect(r.a).to eq "a"
    expect(r.inspect).not_to match "@a"

    r.a = "a+"
    expect(r.a).to eq "a+"
    expect(r.inspect).not_to match "@a"
  end
end
