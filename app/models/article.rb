class Article < ApplicationRecord
  attr_accessor :keyword_score
  
  belongs_to :user, optional: true
  validates :title, :body, :source, presence: true
  has_one :publisher_avatar, as: :imageable, class_name: :Image, dependent: :destroy
  has_one :cover, as: :imageable, class_name: :Image, dependent: :destroy

  enum source: [:nytimes, :washingtonpost, :bbc, :personal]

  def publisher_name
    source == 'personal' && user.present? ? user.profile.print_name : I18n.t("sources.#{source}")
  end

  def train_hash
    {id: id, body: body}
  end
end
