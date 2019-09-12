module Token
  class Generate
    include Peafowl

    attribute :user, ::User
    validates :user, presence: true

    def call
      payload = {
        user_id: user.id,
        iat: Time.now.to_i,
        ttl: ttl.to_i,
        iss: ENV["ISSUER"].to_s,
      }

      token_encode = ::Token::Encode.call(payload: payload)
      add_error!(token_encode.errors) if token_encode.failure?
      token = token_encode.token

      auth_token = ::AuthToken.new
      auth_token.user = user
      auth_token.token = token
      auth_token.expire_at = ttl
      auth_token.save!

      context[:auth_token] = auth_token
    end

    private

    def ttl
      time_expiration = ENV["JWT_EXPIRATION_TIME"] || 10000
      Time.now + time_expiration.to_i.minute
    end
  end
end
