module Profiles
  class ChangeKeywords
    include Peafowl

    attribute :profile, Profile
    attribute :user_keywords, String

    validates :profile, presence: true
    validates :user_keywords, presence: true

    def call
      user_keywords = @user_keywords.to_s.split(',')
      add_error!(I18n.t("profile.errors.keyword_count")) if user_keywords.count > 5
      
      add_keywords(user_keywords)

      context[:profile] = profile
    end

    def add_keywords(keywords)
      if keywords.blank?
        profile.profile_keywords.destroy_all
      else
        ProfileKeyword.joins(:keyword).where('profile_id = ? AND keywords.key NOT IN (?)', profile.id, keywords).destroy_all
      end

      keywords.each do |k|
        key = Keyword.find_or_create_by(key: k)
        profile_keyword = profile.profile_keywords.find_or_create_by(keyword: key)
      end

      keywords = profile.keywords.map(&:key).join(',')
      profile.update(keyword_list: keywords)
      profile.reload
    end
  end
end
