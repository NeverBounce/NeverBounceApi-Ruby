
describe NeverBounce::API::Response::CreditsInfo::Paid do
  include_dir_context __dir__

  it_behaves_like "instantiatable"
  it_behaves_like "properly inherited"

  describe "#subscription_type" do
    it { expect(newo.subscription_type).to eq :paid }
  end
end
