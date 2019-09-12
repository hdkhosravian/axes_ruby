class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :newer, -> { order(created_at: :desc) }
end
