module API
  module V1
    class ArticlesController < ApiController
      before_action :authenticate_user_from_token!
      before_action :find_article, only: [:update, :show, :destory]

      def index
        @articles = Article.where(publish: true, created_at: Time.now.beginning_of_year..Time.now.end_of_year)
          .order(created_at: :desc).page(page_params).per(limit_params)
      end

      def show
        @client_keywords = @current_user.profile.keywords.map(&:key)
        
        if @article.last_analyze.present?
          related = Microservices::Python::Related.article_keywords(
            @python_conn, @article.index, @client_keywords
          )

          @keywords = related["keywords_scores"]
        end

        render "api/v1/articles/show", status: :ok
      end

      def create
        @article = @current_user.articles.create(article_params)
        Image.create(picture: params[:cover], imageable: @article)

        result = Microservices::Python::Related.article_related(
          @python_conn, params[:report], 1000, @client_keywords, params[:body]
        )

        @article.update(
          analyze_category: result["axes_world_category"],
          analyze_results: JSON.parse(result["top_scores"]),
          last_analyze: Time.now
        )

        render "api/v1/articles/show", status: 201
      end

      def update
        @article = Article.update_attributes(article_params)
        render "api/v1/articles/show", status: :ok
      end

      def personals
        @articles = @current_user.articles.order(created_at: :desc).page(page_params).per(limit_params)
      end

      def destroy
        find_article
        @article.destroy
      end

      private

      def find_article
        @article = Article.find(params[:id])
      end

      def article_params
        params.permit(:title, :body, :publish).merge({
          source: 'personal',
          publish_at: (params[:publish] ? Time.now : nil)
        })
      end

      def page_params
        params[:page] || 1
      end
      
      def limit_params
        params[:limit] || 5
      end
    end
  end
end
