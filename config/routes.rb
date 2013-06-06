ElefeelyApi::Application.routes.draw do

  get '/' => 'api_directory#show'

  post '/users' => 'users#create'

  get '/users/me' => 'users#me', as: :user
  put '/users/me' => 'users#update', as: :user
  delete '/users/me' => 'users#destroy', as: :user

  get '/login' => 'users#validate_credentials'

  resources :phones, only: [ :index, :create ]
  delete '/phones/me' => 'phones#destroy', as: :user_phone
  post '/phones/:number' => 'phones#update', as: :phone
  # NOTE: post is used for update because PUT does not accept params in header
  # and in body (from gem)

  resources :feelings, only: [ :index, :create ]
  get '/feelings/me' => 'feelings#me', as: :user_feelings

end
