json.articles articles&.each do |article|
  json.id article.id
  json.title article.title
  json.body article.body.first(100)
  json.source article.publisher_name
  json.image do
    json.partial! "api/v1/shared/image", image: @article&.user&.profile&.avatar || @article&.publisher_avatar
  end
  json.keyword_score article.analyze_results[keyword] if keyword.present? && article.analyze_results.present?
  json.created_at time_ago_in_words(article.created_at)
  json.publish_at time_ago_in_words(article.publish_at) if article.publish_at.present?
  json.last_analyze time_ago_in_words(article.last_analyze) if article.last_analyze.present?
end