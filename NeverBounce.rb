require 'HTTParty'
require 'json';

require './NeverBounce/Errors'
require './NeverBounce/Single'

module NeverBounce
	class API 
	    include HTTParty
        attr_accessor :host, :path, :apikey, :apiSecret, :accessToken, :options
        base_uri 'https://api.neverbounce.com'
        # base_uri 'http://localhost:8000'

		def initialize(apiKey, apiSecret)
            @apiKey = apiKey;
			@apiSecret = apiSecret;
			@accessToken = nil;
    		@options = {:headers => {
    			"Content-Type" => "application/x-www-form-urlencoded",
    			"User-Agent" => "NeverBounce-Ruby/" + VERSION}
    		}

            raise AuthError, "You must provide a NeverBounce API key" unless @apiKey
            raise AuthError, "You must provide a NeverBounce API secret key" unless @apiSecret
        end

        # Rescuable json parser
	    parser(
	      proc do |body, format|
	        begin
	          JSON.parse(body)
	        rescue JSON::ParserError => e
	          raise ResponseError, "The response from NeverBounce was unable " \
                                	"to be parsed as json. Try the request " \
                                	"again, if this error persists " \
                                	"let us know at support@neverbounce.com." \
                                	"\n\n(Internal error)"
	        end
	      end
	    )

	    # Call api endpoint
	    def call(endpoint, body)
	    	begin
	    		opts = body.merge({:access_token => getAccessToken})
	    		request(endpoint, {:body => opts})
	    	# If access token is expired we'll retry the request
	    	rescue AccessTokenExpired
	    		@accessToken = nil
	    		opts = body.merge({:access_token => getAccessToken})
	    		request(endpoint, {:body => opts})
	    	end
	    end

	    # Makes the actual api request
	    def request(endpoint, params)
	      opts = options.merge(params)
	      response = self.class.post(endpoint, opts)

	      # Handle non successful requests
	      if response['success'] === false
	      	if response['msg'] === 'Authentication failed'
	      		raise AccessTokenExpired
	      	end

	        raise RequestError, "We were unable to complete your request. " \
	              				"The following information was supplied: " \
				              	"#{response['msg']} " \
				            	"\n\n(Request error)"
	      end
	      response
	    end

	    # Lets get the access token
	    # If we don't have one available
	    # already we'll request a new one
	    def getAccessToken
	      # Get existing access token if available
	      if @accessToken != nil 
	        return @accessToken
	      end

	      # Perform request if no existing access token
	      response = request('/v3/access_token', 
	        :body => {:grant_type => 'client_credentials', :scope => 'basic user'},
	        :basic_auth => {:username => @apiKey, :password => @apiSecret}
		  )

	      if response['error'] != nil
	      	raise AuthError,	"We were unable to complete your request. " \
                        		"The following information was supplied: " \
                        		"#{response['error_description']}" \
                        		"\n\n(Request error [#{response['error']}])"
	      end

	      @accessToken = response['access_token']
	    end

	    # Initializes the single method
	    def single
	    	Single.new(self)
	    end
	end
end