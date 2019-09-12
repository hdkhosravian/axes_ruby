Rails.application.routes.draw do
  root 'dashboard#index'

  namespace :api do
    namespace :v1 do
      resources :authentications, only: [], path: '' do
        collection do
          post :sign_up
          post :sign_in
          delete :logout
        end
      end

      resources :profiles, only: [] do
        collection do
          get '/', to: 'profiles#show'
          put '/', to: 'profiles#update'
          put :change_password
          post :change_keywords
          get :keywords
          post :upload_avatar
        end
      end

      resources :statistics, only: [] do
        collection do
          get :sources_report
          get :popular_keywords
          get :client_keywords
        end
      end
      
      get 'related/articles/:category_id', to: 'related_articles#articles_related'
      get 'related/keyword/:keyword', to: 'related_articles#keyword_related'
      get 'related/article/:id', to: 'related_articles#article_related'
      get 'related/article_keywords/:id', to: 'related_articles#article_keywords'

      resources :articles do
        collection do
          get :personals
        end
      end
    end
  end

  match '*path', to: 'dashboard#index', via: :all
end
