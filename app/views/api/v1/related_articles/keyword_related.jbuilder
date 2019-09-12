json.partial! "api/v1/shared/client_keywords", keywords: @keywords, client_keywords: @client_keywords
json.partial! "api/v1/shared/popular_keywords", populars: @populars
json.partial! "api/v1/shared/articles", articles: @articles, keyword: @keyword
json.sources_reports do
  json.partial! "api/v1/shared/sources_report", grouped_by_date: @grouped_by_date, presenter: @presenter, count: @count, sources: @sources
end
json.partial! "api/v1/shared/pagination", collection: @articles
