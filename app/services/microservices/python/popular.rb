class Microservices::Python::Popular
  def self.popular_keywords(conn, report, limit, category_id = nil)
    body = {report: report, limit: limit}
    body.merge(category_id: category_id) if category_id.present?

    resp = conn.post('/popular/keywords') do |req|
      req.body = body.to_json
    end

    return JSON.parse(resp.body)
  end
  
  def self.client_keywords(conn, report, keywords, category_id = nil)
    body = {report: report, keywords: keywords}
    body.merge(category_id: category_id) if category_id.present?

    resp = conn.post('/popular/keywords/clients') do |req|
      req.body = body.to_json
    end

    return JSON.parse(resp.body)
  end
end