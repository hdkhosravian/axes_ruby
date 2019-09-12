class ProfileKeyword < ApplicationRecord
  belongs_to :keyword
  belongs_to :profile
end
