module Profiles
  class ChangePassword
    include Peafowl

    attribute :user, User
    attribute :old_password, String
    attribute :password, String
    attribute :confirm_password, String

    validates :user, presence: true
    validates :old_password, presence: true
    validates :password, presence: true
    validates :confirm_password, presence: true

    def call
      add_error!(I18n.t("user.error.old_password")) unless user.valid_password?(old_password)
      add_error!(I18n.t("user.sign_up.errors.password_length")) unless password.size >= 8
      add_error!(I18n.t("user.sign_up.errors.confirm_password")) unless password.eql? confirm_password

      user.update(password: password)
      user.reload

      context[:user] = user
    end
  end
end
