class Microservices::Python::Related
  def self.keyword_related(conn, report, limit, keywords, keyword)
    body = {report: report, limit: limit, keywords: keywords}

    resp = conn.post("/related/articles/#{keyword.delete(' ')}") do |req|
      req.body = body.to_json
    end

    return JSON.parse(resp.body)
  end
  
  def self.article_related(conn, report, limit, keywords, body)
    body = {report: report, limit: limit, keywords: keywords, body: body}

    resp = conn.post('/related/article') do |req|
      req.body = body.to_json
    end

    return JSON.parse(resp.body)
  end

  def self.articles_related(conn, report, limit, keywords, category_id)
    body = {report: report, limit: limit, keywords: keywords, category_id: category_id}

    resp = conn.post('/related/articles') do |req|
      req.body = body.to_json
    end

    return JSON.parse(resp.body)
  end

  def self.article_keywords(conn, article_index, keywords)
    body = { keywords: keywords}

    resp = conn.post("/related/article/#{article_index}") do |req|
      req.body = body.to_json
    end

    return JSON.parse(resp.body)
  end
end