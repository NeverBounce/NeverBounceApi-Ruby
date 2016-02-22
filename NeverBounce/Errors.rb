module NeverBounce
    class Error < StandardError
    end
    class AccessTokenExpired < Error
    end
    class ApiError < Error
    end
    class AuthError < Error
    end
    class ResponseError < Error
    end
    class RequestError < Error
    end
end

