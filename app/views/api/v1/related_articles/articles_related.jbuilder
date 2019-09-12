json.partial! "api/v1/shared/client_keywords", keywords: @keywords, client_keywords: @client_keywords
json.partial! "api/v1/shared/popular_keywords", populars: @populars
json.partial! "api/v1/shared/articles", articles: @articles, keyword: nil
