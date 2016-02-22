require './libs/NeverBounce/Single'
require 'spec_helper'



describe "VerifiedEmail" do
	context "will create new instance from response"  do
		x = NeverBounce::VerifiedEmail.new({
                'success' => true,
                'result' => 0,
                'result_details' => 0,
                'execution_time' => 0.22115206718445
            })

		it "and getResultCode will return 0" do
            expect(x.getResultCode).to eq 0
		end

		it "and getResultTextCode will return 'valid'" do
            expect(x.getResultTextCode).to eq 'valid'
		end

		it "and is will return expected result" do
            expect(x.is(0)).to eq true
            expect(x.is([0])).to eq true
            expect(x.is(1)).to eq false
            expect(x.is([1,2,3])).to eq false
		end

		it "and not will return expected result" do
            expect(x.not(0)).to eq false
            expect(x.not([0])).to eq false
            expect(x.not(1)).to eq true
            expect(x.not([1,2,3])).to eq true
		end
	end
end