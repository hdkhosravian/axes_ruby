module API
  module V1
    class StatisticsController < ApiController
      before_action :authenticate_user_from_token!
      before_action :statistics_presenter

      def sources_report
        date_range = @presenter.report_range(params[:report])
        articles = @presenter.articles(params[:report], date_range)
        @sources = @presenter.sources_report(articles)
        @grouped_by_date = @presenter.group_by_date(Article, params[:report], date_range)
        @count = articles.count
      end

      def popular_keywords
        @populars = Microservices::Python::Popular.popular_keywords(
          @python_conn, params[:report], 5, params[:category_id]
        )
        @populars = @populars["top_keywords"]
      end
      
      def client_keywords
        @client_keywords = @current_user.profile.keywords.map(&:key)
        @keywords = Microservices::Python::Popular.client_keywords(
          @python_conn, params[:report], @client_keywords, params[:category_id]
        )
        @keywords = @keywords["keywords_scores"]
      end

      private
      
      def statistics_presenter
        @presenter = ::Presenters::Statistics.new(@current_user)
      end

      def page_params
        params[:page] || 1
      end
      
      def limit_params
        params[:limit] || 10
      end
    end
  end
end