ElefeelyApi::Application.routes.draw do
  resources :users
  get '/phones/verified' => 'phones#verified', as: :verified_phones
  resources :feelings, only: [ :create ]
end
