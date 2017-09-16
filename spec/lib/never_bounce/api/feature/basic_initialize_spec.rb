
describe NeverBounce::API::Feature::BasicInitialize do
  let(:klass) do
    feature = described_class
    Class.new do
      feature.load(self)

      attr_accessor :a, :b

      private

      def c=(value)
        @c = value
      end
    end
  end

  it "generally works" do
    r = klass.new(a: 12, b: "34")
    expect(r.a).to eq 12
    expect(r.b).to eq "34"

    expect { klass.new(c: 12) }.to raise_error(NoMethodError, /\bprivate method `c='/)
  end
end
