class Train::Yearly
  def yearly(conn)
    articles = Article.where(publish: true, created_at: Time.now.beginning_of_year..Time.now.end_of_year)
    training = Microservices::Python::Train.train(conn, 'year', articles.map(&:train_hash))

    training["results"].each do |result|
      article = Article.find_by(id: result["id"])
      article.update(
        analyze_category: result["axes_world_category"],
        analyze_results: JSON.parse(result["top_scores"]),
        last_analyze: Time.now,
        index: result["index"],
      )
    end
  end
end