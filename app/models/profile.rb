class Profile < ApplicationRecord
  belongs_to :user
  has_many :profile_keywords
  has_many :keywords, through: :profile_keywords
  has_one :avatar, as: :imageable, class_name: :Image, dependent: :destroy

  def print_name
    "#{first_name} #{last_name}"
  end
end
