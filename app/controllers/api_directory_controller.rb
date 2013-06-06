class ApiDirectoryController < ApplicationController
  def show
    render json: {
                   'feelings_url'              => 'http://elefeely-api.herokuapp.com/feelings',
                   'users_url'                 => 'http://elefeely-api.herokuapp.com/users',
                   'current_user_url'          => 'http://elefeely-api.herokuapp.com/users/me',
                   'current_user_phone_url'    => 'http://elefeely-api.herokuapp.com/phones/me',
                   'current_user_feelings_url' => 'http://elefeely-api.herokuapp.com/feelings/me',
                   'phone_url'                 => 'http://elefeely-api.herokuapp.com/phones/{number}',
                   'login_url'                 => 'http://elefeely-api.herokuapp.com/login',
                   'phones_url'                => 'http://elefeely-api.herokuapp.com/phones'
                 }
  end
end
