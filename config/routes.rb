Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      post 'users/register', :to => 'users#register_user'

      post 'users/session', :to => 'sessions#create'
      post 'users/auth/google', :to => 'sessions#google_auth'

      get 'user_whitelists', :to => 'user_whitelists#index'
      post 'user_whitelists', :to => 'user_whitelists#create'

      get 'topics', :to => 'topics#index'
      get 'topics/:id', :to => 'topics#show'
      post 'topics/follow', :to => 'topics#follow'
      post 'topics/unfollow', :to => 'topics#unfollow'

      get  'top/questions', :to => 'questions#top'
      get  'profile/questions', :to => 'questions#profile'
      get  'profile/answers', :to => 'answers#profile'

      get 'questions', :to => 'questions#index'
      get 'questions/top', :to => 'questions#top'
      get 'questions/profile', :to => 'questions#profile'
      get 'questions/:id', :to => 'questions#show'
      post 'questions', :to => 'questions#create'
      put 'questions/:id', :to => 'questions#update'
      post 'questions/vote', :to => 'questions#vote'
      post 'questions/follow', :to => 'questions#follow'
      post 'questions/unfollow', :to => 'questions#unfollow'

      get 'answers', :to => 'answers#index'
      get 'answers/:id', :to => 'answers#show'
      post 'answers', :to => 'answers#create'
      put 'answers/:id', :to => 'answers#update'
      post 'answers/vote', :to => 'answers#vote'

      get 'comments', :to => 'comments#index'
      get 'comments/:id', :to => 'comments#show'
      post 'comments', :to => 'comments#create'
      post 'comments/vote', :to => 'comments#vote'

      get  'drafts', :to => 'drafts#index'
      post 'drafts', :to => 'drafts#create'
      get  'drafts/me', :to => 'drafts#me'
    end
  end

  # Catch all return 404
  match '*path', to: -> (env) { [404, {}, ['{"error": "Not match url"}']] }, via: :all
end
