module NeverBounce 
	class Single
		attr_accessor :master

        def initialize(master)
            @master = master
        end

        # Makes verification request
        # Returns VerifiedEmail instance
		def verify(email)
			VerifiedEmail.new(@master.call('/v3/single', {:email => email}))
		end
	end
	class VerifiedEmail

		def initialize(response)
			@response = response
			@textCodes = ['valid','invalid','disposable','catchall','unknown']
		end

		# Returns numeric result code
		def getResultCode
			@response['result']
		end

		# Returns textual result code
		def getResultTextCode
			@textCodes[@response['result']]
		end

		# Returns true if result is in the specified codes
		# Accepts either array of result codes or single result code
		def is(codes)
			if codes.kind_of?(Array)
				codes.include?(@response['result'])
			else
				codes === @response['result']
			end
		end

		# Returns true if result is NOT in the specified codes
		# Accepts either array of result codes or single result code
		def not(codes)
			if codes.kind_of?(Array)
				!codes.include?(@response['result'])
			else
				codes != @response['result']
			end
		end

	end
end