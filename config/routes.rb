ElefeelyApi::Application.routes.draw do

  resources :users, except: [ :show ]
  get '/users/me' => 'users#me'
  get '/login' => 'users#validate_credentials'

  resources :phones, only: [ :index, :create ]
  delete '/phones/me' => 'phones#destroy'
  put '/phones/:number' => 'phones#update'

  resources :feelings, only: [ :index, :create ]
  get '/feelings/me' => 'feelings#me'

end
