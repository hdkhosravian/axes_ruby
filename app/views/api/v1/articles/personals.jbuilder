json.partial! "api/v1/shared/articles", articles: @articles, keyword: nil
json.partial! "api/v1/shared/pagination", collection: @articles
