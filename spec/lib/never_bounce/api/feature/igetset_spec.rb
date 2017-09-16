
describe NeverBounce::API::Feature::Igetset do
  let(:klass) do
    feature = described_class

    Class.new do
      feature.load(self)

      attr_writer :is_a, :is_b

      def is_a
        igetset(:is_a) do
          seq << :is_a_block
          false
        end
      end

      def is_b
        igetset(:is_a) do
          seq << :is_b_block
          nil
        end
      end

      # Store call sequence here.
      def seq
        @log ||= []
      end
    end
  end

  it "generally works" do
    r = klass.new
    expect(r.seq).to eq []
    expect(r.is_a).to be false
    expect(r.is_a).to be false
    expect(r.seq).to eq [:is_a_block]   # Block evaluation is logged once.

    r = klass.new
    expect(r.seq).to eq []
    expect(r.is_b).to be nil
    expect(r.is_b).to be nil
    expect(r.seq).to eq [:is_b_block]
  end
end
