ElefeelyApi::Application.routes.draw do

  resources :users, except: [ :show ]
  get '/users/me' => 'users#me'

  resources :phones, only: [ :index, :create ]
  put '/phones/:number' => 'phones#update'

  resources :feelings, only: [ :index, :create ]

end
