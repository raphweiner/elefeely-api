ElefeelyApi::Application.routes.draw do

  resources :users

  resources :phones, only: [ :index, :create ]
  put '/phones/:number' => 'phones#update'

  resources :feelings, only: [ :create ]

end
