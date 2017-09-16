
shared_context __dir__ do
  shared_examples "properly inherited" do
    it "doesn't have duplicate oattrs" do
      expect((oattrs = described_class.oattrs).uniq).to eq oattrs
    end
  end
end
