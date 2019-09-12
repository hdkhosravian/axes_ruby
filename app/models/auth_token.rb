class AuthToken < ApplicationRecord
  belongs_to :user

  validates :token, presence: true, length: { minimum: 20 }, uniqueness: true
end
