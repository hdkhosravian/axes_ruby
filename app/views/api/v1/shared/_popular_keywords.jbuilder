json.top_keywords populars&.each do |key|
  json.name key["feature"]
  json.percentage (key["tfidf"].to_f * 100).round(2)
end