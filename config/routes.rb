Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    post 'users', to: 'users#create'
    post 'users/:user_id/follow/:id', to: 'users#follow'
    post 'users/:user_id/unfollow/:id', to: 'users#unfollow'
    get 'users/:id/followers', to: 'users#followers'
  end
end
