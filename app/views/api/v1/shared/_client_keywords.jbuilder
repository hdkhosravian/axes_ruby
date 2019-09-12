json.keywords keywords&.each_with_index.to_a do |(value, index)|
  json.name client_keywords[index]
  json.percentage (value.to_f * 100).round(2)
end