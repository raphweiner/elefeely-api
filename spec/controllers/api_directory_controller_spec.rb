require 'spec_helper'

describe ApiDirectoryController do
  describe 'GET #show' do
    it 'returns all available API calls' do
      get :show
      expect(JSON.parse(response.body)).to eq({
                                                'feelings_url' => '/feelings',
                                                 'users_url' => '/users',
                                                 'current_user_url' => '/users/me',
                                                 'current_user_phone_url' => '/phones/me',
                                                 'current_user_feelings_url' => '/feelings/me',
                                                 'phone_url' => '/phones/{number}',
                                                 'login_url' => '/login',
                                                 'verified_phones_url' => '/phones'
                                                 })
    end
  end
end
