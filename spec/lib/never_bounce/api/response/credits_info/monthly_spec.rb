
describe NeverBounce::API::Response::CreditsInfo::Monthly do
  include_dir_context __dir__

  it_behaves_like "instantiatable"
  it_behaves_like "properly inherited"

  describe "#subscription_type" do
    it { expect(newo.subscription_type).to eq :monthly }
  end
end
