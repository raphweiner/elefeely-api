class ApiDirectoryController < ApplicationController
  def show
    render json: {
                   'feelings_url' => '/feelings',
                   'users_url' => '/users',
                   'current_user_url' => '/users/me',
                   'current_user_phone_url' => '/phones/me',
                   'current_user_feelings_url' => '/feelings/me',
                   'phone_url' => '/phones/{number}',
                   'login_url' => '/login',
                   'verified_phones_url' => '/phones'
                 }
  end
end
