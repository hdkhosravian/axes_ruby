class Microservices::Python::Train
  def self.train(conn, report, articles)
    body = {report: report, articles: articles}

    resp = conn.post("/train/") do |req|
      req.body = body.to_json
    end

    return JSON.parse(resp.body)
  end
end