json.count @count

json.sources @sources&.each do |s|
  json.name s["name"]
  json.count s["count"]
  json.image s["image"]
  json.percentage @presenter.calculate_percentage(s["count"], @count) 
end

json.chart do
  json.labels @grouped_by_date.keys
  json.data @grouped_by_date.values
end