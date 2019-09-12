class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :encrypted_password, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }

  before_save { email.downcase! }
  after_create :create_profile

  has_one :profile
  has_many :articles
  has_many :auth_tokens, autosave: true

  def valid_password?(password)
    BCrypt::Password.new(self.encrypted_password) == password
  end

  def password=(password)
    raise BadRequestError, I18n.t("user.sign_up.errors.password_length") if password.size < 8
    self.encrypted_password = BCrypt::Password.create(password) if password.present?
  end

  def token
    auth_tokens.newer.first
  end

  private
  
  def create_profile
    self.create_profile!
  end
end
