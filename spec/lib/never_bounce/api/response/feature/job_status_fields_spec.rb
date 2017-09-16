
module NeverBounce; module API; module Response; module Feature
  describe JobStatusFields do
    context "when invalid class" do
      it "generally works" do
        feature = described_class
        expect { Class.new { feature.load(self) } }.to raise_error(ArgumentError, /is not an ancestor of Response::Container$/)
      end
    end

    context "when valid class" do
      it "generally works" do
        feature = described_class

        klass = Class.new(Response::StatusMessage) { feature.load(self) }

        # Use a complete real-world example.
        r = klass.new(body_hash: {"status"=>"success", "id"=>302499, "job_status"=>"complete", "filename"=>"20170815-103321.csv", "created_at"=>"2017-08-15 17:19:41", "started_at"=>"2017-08-15 17:19:42", "finished_at"=>"2017-08-15 17:19:45", "total"=>{"records"=>11, "billable"=>12, "processed"=>13, "valid"=>14, "invalid"=>15, "catchall"=>16, "disposable"=>17, "unknown"=>18, "duplicates"=>19, "bad_syntax"=>20}, "bounce_estimate"=>34.56, "percent_complete"=>100, "execution_time"=>99})
        expect(r.id).to eq 302499
        expect(r.job_status).to eq "complete"
        expect(r.filename).to eq "20170815-103321.csv"
        expect(r.created_at).to eq "2017-08-15 17:19:41"
        expect(r.started_at).to eq "2017-08-15 17:19:42"
        expect(r.finished_at).to eq "2017-08-15 17:19:45"
        expect(r.bounce_estimate).to eq 34.56
        expect(r.percent_complete).to eq 100
        expect(r.execution_time).to eq 99
        expect(total = r.total).to be_a described_class::Total
        expect(total.records).to eq 11
        expect(total.billable).to eq 12
        expect(total.processed).to eq 13
        expect(total.valid).to eq 14
        expect(total.invalid).to eq 15
        expect(total.catchall).to eq 16
        expect(total.disposable).to eq 17
        expect(total.unknown).to eq 18
        expect(total.duplicates).to eq 19
        expect(total.bad_syntax).to eq 20
      end
    end
  end
end; end; end; end
