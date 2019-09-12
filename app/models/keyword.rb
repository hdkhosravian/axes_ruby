class Keyword < ApplicationRecord
  validates :key, presence: true

  has_many :profile_keywords
  has_many :profiles, through: :profile_keywords
end
