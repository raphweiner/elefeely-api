require 'spec_helper'

describe PhonesController do
  describe 'GET #verified' do
    context 'happy path' do
      before(:all) do
        @user = User.create!(email: 'barbar@laroyaume.com', password: 'mot-de-cle')
        @phone = Phone.create!(user: @user, number: '4157451286', verified: true)
      end

      it 'returns all verified phone numbers in json' do
        params = 'something'
        get :verified, params
        expect(response.body).to eq({'phone_numbers' => ['4157451286']}.to_json)
      end
    end
  end
end
