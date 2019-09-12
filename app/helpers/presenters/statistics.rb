class Presenters::Statistics
  def initialize(user)
    @user = user
  end

  def calculate_percentage(value, full)
    ((value.to_f/full.to_f)*100).round(2)
  end

  def sources_report(articles)
    sources = []
    personals = []
    
    articles.where.not(source: :personal).order(:source).limit(5).group(:source).count.each do |s|
      source = {}
      source['name'] = I18n.t("sources.#{s[0]}")
      source['count'] = s[1]
      source['image'] = "#{ENV["UPLOAD_SERVER"]}/sources/images/#{I18n.t("sources.#{s[0]}")}.png"
      sources << source
    end

    articles.where(source: :personal).where.not(user_id: nil).order(:user_id).limit(5).group(:user_id).count.each do |person|
      user = User.find(person[0])
      personal = {}
      personal['name'] = user&.profile.print_name
      personal['count'] = person[1]
      personal['image'] = user&.profile&.avatar&.picture&.url(:medium)
      personals << personal
    end

    results = sources.concat(personals).sort_by { |k| k["count"] }
    results.reverse!
  end

  def articles(report, report_range)
    case report
    when "all"
      articles = Article.all
    else
      articles = Article.where(created_at: report_range)
    end

    articles
  end

  def report_range(report)
    case report
    when "day"
      Time.now.beginning_of_day..Time.now
    when "week"
      Time.now.beginning_of_week..Time.now
    when "month"
      Time.now.beginning_of_month..Time.now
    when "year"
      Time.now.beginning_of_year..Time.now
    end
  end
  
  def group_by_date(object, report, range)
    case report
    when "day"
      grouped = object.group_by_hour_of_day(:created_at, range: range, format: "%H:%M").count
    when "year"
      grouped = object.group_by_month(:created_at, range: range, format: "%B").count
    else
      grouped = object.group_by_day(:created_at, range: range).count
    end

    grouped
  end
end