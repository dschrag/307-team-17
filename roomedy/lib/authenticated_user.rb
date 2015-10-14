class AuthenticatedUser < Struct.new(:value)
    def matches?(request)
        request.cookies.key?("user_token") == value
    end
end