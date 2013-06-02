ElefeelyApi::Application.routes.draw do

  resources :password_resets, only: [ :create, :edit, :update ]

  resources :users

  resources :phones, only: [ :index, :create ]
  put '/phones/:number' => 'phones#update'

  resources :feelings, only: [ :index, :create ]

end
