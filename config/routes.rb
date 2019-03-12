Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    resource :session, only: [:create, :destroy]
    resources :topics, only: [:index, :show, :create, :destroy]
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

    post 'topics/follow', :to => 'topics#follow'
    post 'topics/unfollow', :to => 'topics#unfollow'

    namespace :v1 do
      post 'users/session', :to => 'sessions#create'
      post 'users/auth/google', :to => 'sessions#google_auth'

    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "registrations" }

end
