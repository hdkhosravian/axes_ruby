class Train::Weekly
  def weekly(conn)
    articles = Article.where(publish: true, created_at: Time.now.beginning_of_week..Time.now.end_of_week)
    training = Microservices::Python::Train.train(conn, 'week', articles.map(&:train_hash))
  end
end