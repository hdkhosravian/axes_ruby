module Authentications
  class Authenticate
    include Peafowl

    attribute :auth_token, String
    validates :auth_token, presence: true

    def call
      raise AuthorizationError unless valid_to_proceed?
      current_user = ::User.find_by_id(decoded_auth_token[:user_id])
      context[:current_user] = current_user
    end

    private

    # check user has access or not for a request
    def valid_to_proceed?
      decoded_auth_token.present? && decoded_auth_token[:user_id].present? && valid_token?
    end

    # check user token and validation of token
    def valid_token?
      token = ::AuthToken.where(user_id: decoded_auth_token[:user_id]).newer.first
      token&.token == auth_token && token.expire_at >= Time.now if token.present?
    end

    # decode the token and return the response
    def decoded_auth_token
      result = Token::Decode.call(token: auth_token)
      add_error!(result.errors) if result.failure?
      result.decoded.first.deep_symbolize_keys
    end
  end
end
