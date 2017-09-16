
describe NeverBounce::API::Response::CreditsInfo::Base do
  include_dir_context __dir__

  it_behaves_like "instantiatable"
  it_behaves_like "properly inherited"

  let(:klass) do
    Class.new(described_class) do
      attr_accessor :subscription_type
    end
  end

  describe "#monthly?" do
    it "generally works" do
      r = klass.new
      r.subscription_type = :monthly
      expect(r.monthly?).to be true
      expect(r.paid?).to be false
    end
  end

  describe "#paid?" do
    it "generally works" do
      r = klass.new
      r.subscription_type = :paid
      expect(r.monthly?).to be false
      expect(r.paid?).to be true
    end
  end
end
