require 'spec_helper'

describe UsersController do
  describe 'POST #create' do
    before(:each) do
      controller.stub(:send_welcome_email)
    end

    context 'with a new email and password' do

      let(:params ) { { user: {email: 'direngezi@parki.com', password: 'iisyan'} } }

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
        User.create!(email: "mert@okul.com", password: "passypass")
      end

      let(:params) { {user: {email: "mert@okul.com", password: "canlicanli"} } }

      it 'returns errors on model' do
        post :create, params
        expect(JSON.parse(response.body)).to eq({"email"=>["has already been taken"]})
      end

      it 'returns 422, unprocessable entity' do
        post :create, params
        expect(response.code).to eq '422'
      end
    end

    context 'without required user parameters and with invalid ones' do
      it 'returns errors on model' do
        post :create, {user: { password: 'hi' }}
        expect(JSON.parse(response.body)).to eq({"email" => ["can't be blank"],
                                                 "password" => ["is too short (minimum is 6 characters)"]})
      end
    end
  end
end
