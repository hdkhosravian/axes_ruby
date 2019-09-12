module API
  module V1
    class RelatedArticlesController < ApiController
      before_action :authenticate_user_from_token!

      def article_keywords
        article = Article.find(params[:id])
        @client_keywords = params[:search].to_s.split(',')

        related = Microservices::Python::Related.article_keywords(
          @python_conn, article.index, @client_keywords
        )

        @keywords = related["keywords_scores"]
      end

      def keyword_related
        @client_keywords = @current_user.profile.keywords.map(&:key)

        related = Microservices::Python::Related.keyword_related(
          @python_conn, params[:report], limit_article.to_i, @client_keywords, params[:keyword]
        )

        articles_ids = []
        related['articles']&.map{|article| articles_ids << article['id']}

        @articles = Article.where(id: articles_ids)
        @keywords = related["keywords_scores"]
        @populars = related["top_keywords"]
        @keyword = params[:keyword]
        sources_report
        @articles = @articles.page(page_params).per(limit_params)
      end

      def article_related
        body = Article.find(params[:id]).body
        @client_keywords = @current_user.profile.keywords.map(&:key)

        related = Microservices::Python::Related.article_related(
          @python_conn, params[:report], 1000, @client_keywords, body
        )

        @articles = Article.find(related["articles_ids"])
        @keywords = related["keywords_scores"]
        @populars = related["top_keywords"]
        sources_report
        @articles = @articles.page(page_params).per(limit_params)
      end

      def articles_related
        @client_keywords = @current_user.profile.keywords.map(&:key)

        related = Microservices::Python::Related.articles_related(
          @python_conn, params[:report], 1000, @client_keywords, params[:category_id]
        )

        @articles = Article.find(related["articles_ids"])
        @keywords = related["keywords_scores"]
        @populars = related["top_keywords"]
        sources_report
        @articles = @articles.page(page_params).per(limit_params)
      end

      private
      def page_params
        params[:page] || 1
      end
      
      def limit_params
        params[:limit] || 10
      end

      def limit_article
        params[:limit_article] || 100
      end
      
      def sources_report
        @presenter = ::Presenters::Statistics.new(@current_user)
        date_range = @presenter.report_range(params[:report])
        @sources = @presenter.sources_report(@articles)
        @grouped_by_date = @presenter.group_by_date(Article, params[:report], date_range)
        @count = @articles.count
      end
    end
  end
end