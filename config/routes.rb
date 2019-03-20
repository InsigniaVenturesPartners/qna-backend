Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    resources :questions, only: [:index, :show, :create, :update, :destroy]
    resources :answers, only: [:index, :show, :create, :update, :destroy]
    resources :comments, only: [:index, :show, :create, :destroy]
    resources :user_whitelists, only: [:index, :create]

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
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

end
