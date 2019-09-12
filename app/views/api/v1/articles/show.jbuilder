json.id @article.id
json.body @article.body
json.title @article.title
json.publish @article.publish
json.source_url @article.source_url
json.source @article.publisher_name
json.image do
  json.partial! "api/v1/shared/image", image: @article&.user&.profile&.avatar || @article&.publisher_avatar
end
json.cover do
  json.partial! "api/v1/shared/image", image: @article&.cover
end
json.publish_at @article.publish_at.present? ? time_ago_in_words(@article.publish_at) : nil
json.created_at time_ago_in_words(@article.created_at)
json.updated_at time_ago_in_words(@article.updated_at)
json.last_analyze @article.last_analyze.present? ? time_ago_in_words(@article.last_analyze) : nil
json.partial! "api/v1/shared/client_keywords", keywords: @keywords, client_keywords: @client_keywords
json.partial! "api/v1/shared/popular_keywords", populars: @article.analyze_results.present? ? @article.analyze_results : []
