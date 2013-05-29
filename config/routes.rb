ElefeelyApi::Application.routes.draw do
  resources :users
  get '/phones' => 'phones#index', as: :phones
  resources :feelings, only: [ :create ]
end
