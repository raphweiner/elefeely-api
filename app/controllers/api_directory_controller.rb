class ApiDirectoryController < ApplicationController
  def show
    render json: {
                   'feelings_url'              => feelings_url(host: ENV['HOST']),
                   'users_url'                 => users_url(host: ENV['HOST']),
                   'current_user_url'          => user_url(host: ENV['HOST']),
                   'current_user_phone_url'    => user_phone_url(host: ENV['HOST']),
                   'current_user_feelings_url' => user_feelings_url(host: ENV['HOST']),
                   'phone_url'                 => phone_url(host: ENV['HOST'], number: 'NUMBER').sub('NUMBER', '{number}'),
                   'login_url'                 => login_url(host: ENV['HOST']),
                   'phones_url'                => phones_url(host: ENV['HOST'])
                 }
  end
end
