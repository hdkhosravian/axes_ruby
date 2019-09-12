module Authentications
  class SignUp
    include Peafowl

    attribute :email, String
    attribute :password, String
    attribute :confirm_password, String

    validates :email, presence: true
    validates :password, presence: true
    validates :confirm_password, presence: true

    def call
      add_error!(I18n.t("user.sign_up.errors.password_length")) unless password.size >= 8
      add_error!(I18n.t("user.sign_up.errors.confirm_password")) unless password.eql? confirm_password

      user = ::User.create!(email: email, password: password)
      context[:user] = user
    end
  end
end
