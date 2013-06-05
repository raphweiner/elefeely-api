require 'spec_helper'

describe UsersController do
  describe 'POST #create' do
    context 'with a new email and password' do
      let(:params ) { { user: {email: 'direngezi@parki.com', password: 'iisyan'} } }

      it 'creates a new user' do
        expect {
          post :create, params
        }.to change { User.count }.by 1
      end

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
        expect(JSON.parse(response.body)).to eq({"email" => ["can't be blank"]})
      end
    end
  end

  describe 'GET #me' do
    let!(:user) { User.create!(email: 'yo@lo.com', password: 'password') }

    context 'with a valid token' do
      it 'returns the current user' do
        get :me, { token: user.token }
        expect(response.body).to eq user.to_json
      end

      it 'returns a 200' do
        get :me, { token: user.token }
        expect(response.code).to eq '200'
      end
    end

    context 'without a valid token' do
      it 'returns nil' do
        get :me
        expect(JSON.parse(response.body)).to eq("error" => "unauthorized")
      end

      it 'returns a 401' do
        get :me
        expect(response.code).to eq '401'
      end
    end
  end

  describe 'GET #validate_credentials' do
    let!(:user) { User.create!(email: 'yo@lo.com', password: 'password') }

    context 'with a valid email and password' do
      it 'returns the user with their token' do
        get :validate_credentials, { user: { email: 'yo@lo.com', password: 'password' } }
        expect(JSON.parse(response.body)['token']).to eq user.token
      end

      it 'returns a 200' do
        get :validate_credentials, { user: { email: 'yo@lo.com', password: 'password' } }
        expect(response.code).to eq '200'
      end
    end

    context 'with an incorrect password' do
      it 'returns errors on the user' do
        get :validate_credentials, { user: { email: 'yo@lo.com', password: 'abc' } }
        expect(JSON.parse(response.body)).to eq({'error' => 'wrong email/password combination'})
      end

      it 'returns bad request 400' do
        get :validate_credentials, { user: { email: 'yo@lo.com', password: 'abc' } }
        expect(response.code).to eq '400'
      end
    end
  end

  describe 'PUT #update' do
    let!(:user) { User.create!(email: 'raphaelio@gmail.com', password: 'password') }

    context 'with a valid token' do
      context 'and valid params' do
        let(:params) { { token: user.token, user: { email: 'rafiki@gmail.com' } } }

        it 'updates the user' do
          put :update, params
          user.reload

          expect(user.email).to eq 'rafiki@gmail.com'
        end

        it 'returns 200' do
          put :update, params

          expect(response.code).to eq '200'
        end

        context 'with an email that already exists' do
          before(:each) do
            User.create!(email: 'rafiki@gmail.com', password: 'password')
          end

          it 'returns the error' do
            put :update, params

            expect(JSON.parse(response.body)).to eq({"email"=>["has already been taken"]})
          end

          it 'returns a 400' do
            put :update, params

            expect(response.code).to eq '400'
          end
        end
      end

      context 'with invalid params' do
        let(:params) { { token: user.token, user: { abc: 'rafiki@gmail.com' } } }

        it 'raises an error user' do
          expect {
            put :update, params
          }.to raise_error ActiveModel::MassAssignmentSecurity::Error
        end
      end
    end

    context 'with an invalid token' do
      it 'returns a 401' do
        put :update

        expect(response.code).to eq '401'
      end
    end
  end
end
