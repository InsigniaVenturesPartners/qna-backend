Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    resources :answers, only: [:index, :show, :create, :update, :destroy]
    resources :comments, only: [:index, :show, :create, :destroy]

    get  'profile/questions', :to => 'questions#profile'
    get  'profile/answers', :to => 'answers#profile'

    get  'top/questions', :to => 'questions#top'
    post 'questions/vote', :to => 'questions#vote'
    post 'questions/follow', :to => 'questions#follow'
    post 'questions/unfollow', :to => 'questions#unfollow'

    post 'answers/vote', :to => 'answers#vote'

    namespace :v1 do
      post 'users/session', :to => 'sessions#create'
      post 'users/auth/google', :to => 'sessions#google_auth'

      get 'user_whitelists', :to => 'user_whitelists#index'
      post 'user_whitelists', :to => 'user_whitelists#create'

      get 'topics', :to => 'topics#index'
      get 'topics/:id', :to => 'topics#show'
      post 'topics/follow', :to => 'topics#follow'
      post 'topics/unfollow', :to => 'topics#unfollow'

      get 'api/top/questions', :to => 'questions#top'

      get 'questions', :to => 'questions#index'
      get 'questions/:id', :to => 'questions#show'
      post 'questions', :to => 'questions#create'
      patch 'questions/:id', :to => 'questions#update'
    end
  end

  # Catch all return 404
  match "*path", to: -> (env) { [404, {}, ['{"error": "not match url"}']] }, via: :all
end
