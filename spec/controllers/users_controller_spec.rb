require 'spec_helper'

describe UsersController do
  describe 'POST #create' do
    context 'with a new email and password' do
      let(:params ) { { user: {email: 'direngezi@parki.com', password: 'isyan'} } }

      it 'creates a new user' do
        expect {
          post :create, params
        }.to change { User.count }.by 1
      end

      it 'returns the session login cookie'
        # Need to figure out how to manage CORS cookies with backbone

      it 'returns a 200' do
        post :create, params
        expect(response.code).to eq '200'
      end
    end

    context 'with an existing email' do
      before(:each) do
        User.create!(email: "mert@okul.com", password: "pass")
      end

      let(:params) { {user: {email: "mert@okul.com", password: "canli"} } }

      it 'returns errors on model' do
        post :create, params
        expect(JSON.parse(response.body)).to eq({"email"=>["has already been taken"]})
      end

      it 'returns 400, bad request' do
        post :create, params
        expect(response.code).to eq '400'
      end
    end

    context 'without all required user parameters' do
      it 'returns errors on model' do
        post :create, {user: {password: "canli"} }
        expect(JSON.parse(response.body)).to eq({"email"=>["can't be blank"]})
      end
    end
  end
end
