
require "never_bounce/api/version"

describe NeverBounce::API do
  describe "VERSION" do
    it { expect(described_class::VERSION).to eq "1.0.0" }
  end
end
