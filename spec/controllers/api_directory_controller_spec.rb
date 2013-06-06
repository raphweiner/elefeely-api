require 'spec_helper'

describe ApiDirectoryController do
  describe 'GET #show' do
    it 'returns all available API calls' do
      get :show
      expect(JSON.parse(response.body)).to eq({
         'feelings_url'              => 'http://elefeely-api.herokuapp.com/feelings',
         'users_url'                 => 'http://elefeely-api.herokuapp.com/users',
         'current_user_url'          => 'http://elefeely-api.herokuapp.com/users/me',
         'current_user_phone_url'    => 'http://elefeely-api.herokuapp.com/phones/me',
         'current_user_feelings_url' => 'http://elefeely-api.herokuapp.com/feelings/me',
         'phone_url'                 => 'http://elefeely-api.herokuapp.com/phones/{number}',
         'login_url'                 => 'http://elefeely-api.herokuapp.com/login',
         'verified_phones_url'       => 'http://elefeely-api.herokuapp.com/phones'
         })
    end
  end
end
