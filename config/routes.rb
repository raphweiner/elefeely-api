ElefeelyApi::Application.routes.draw do

  resources :users, except: [ :show ]
  get '/users/me' => 'users#me'
  get '/login' => 'users#validate_credentials'

  resources :phones, only: [ :index, :create ]
  delete '/phones/me' => 'phones#destroy'
  post '/phones/:number' => 'phones#update'
  # NOTE: post is used for update because PUT does not accept params in header
  # and in body (from gem)

  resources :feelings, only: [ :index, :create ]
  get '/feelings/me' => 'feelings#me'

end
