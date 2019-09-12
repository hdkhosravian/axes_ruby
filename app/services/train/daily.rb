class Train::Daily
  def daily(conn)
    articles = Article.where(publish: true, created_at: Time.now.beginning_of_day..Time.now.end_of_day)
    training = Microservices::Python::Train.train(conn, 'day', articles.map(&:train_hash)) if articles.present?
  end
end