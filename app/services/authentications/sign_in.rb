module Authentications
  class SignIn
    include Peafowl

    attribute :email, String
    attribute :password, String

    validates :email, presence: true
    validates :password, presence: true

    def call
      user = ::User.find_by(email: email)
      add_error!(I18n.t("user.sign_in.errors.invalid_email_or_password")) unless user.present? && user.valid_password?(password)

      auth_token = generate_auth_token(user)

      context[:user] = user
    end

    private

    def generate_auth_token(user)
      auth_token = ::Token::Generate.call(user: user)
      add_error!(auth_token.errors) if auth_token.failure?

      auth_token
    end
  end
end
