class Train::Monthly
  def monthly(conn)
    articles = Article.where(publish: true, created_at: Time.now.beginning_of_month..Time.now.end_of_month)
    training = Microservices::Python::Train.train(conn, 'month', articles.map(&:train_hash))
  end
end