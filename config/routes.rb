require 'sidekiq/web'
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do 
    namespace :v1 do 
      mount_devise_token_auth_for 'User', at: 'auth'


      #route to retrieve anticipation covers
      get 'anticipation_covers', to: 'anticipation_covers#index'


      #route to retrieve user nofitications
      get 'notifications', to: 'notifications#index'

      #route to mark notification as read 
      put 'notifications/:id', to: 'notifications#mark_read'

      #route to mark all notifications
      get 'mark_all_notifications', to: 'notifications@mark_all'

      #routes to technologies 
      get 'technologies', to: 'technologies#index'

      #routes for web_push_notifications
      post 'web_push_notifications', to: 'web_push_notifications#create'

      #route to get unfulfilled_anticipations 
      get 'unfulfilled_anticipations', to: 'unfulfilled_anticipations#index'
      #users routes
      resources :users, only: [:index, :show] do 
        member do 
          get 'projects', to: 'users#project_index'
          get 'suggestions', to: 'users#suggestion_index'
          get 'anticipations', to: 'users#anticipation_index'
          get 'followers', to: 'users#follower_index'
          get 'followings', to: 'users#following_index'
          post 'followings', to: 'users#up'
          delete 'followings', to: 'users#down'
        end
      end

      #project routes 
      resources :projects, only: [:create, :update, :destroy, :show, :index] do 

        member do 
          post 'likes', to: 'projects#up'
          delete 'likes', to: 'projects#down'
          post 'voters', to: 'projects#upvote'
          delete 'voters', to: 'projects#downvote'
          get 'suggestions', to: 'projects#suggestion_index'

        end

      end

      #anticipations routes 
      resources :anticipations, only: [:show, :update, :create] do 
        member do 
          post 'likes', to: 'anticipations#up'
          delete 'likes', to: 'anticipations#down'
          post 'suscribers', to: 'anticipations#suscribe'
          delete 'suscribers', to: 'anticipations#unsuscribe'

        end

      end

      #suggestions
      resources :suggestions, only: [:create, :update, :index] do 
        put 'complete', to: 'suggestions#mark_as_done'
        get 'suggestions', to: 'suggestions#index'

      end
      
    end
  end

end
