require 'spec_helper'

describe UsersController do
  describe 'POST #create' do
    context 'happy path' do
      let(:params) do
        { user: { email: 'raphael@example.com',
                  password: 'password' } }
      end
    end

    context 'sad path' do
    end
  end
end
