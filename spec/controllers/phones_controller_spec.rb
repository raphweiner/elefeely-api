require 'spec_helper'

describe PhonesController do
  describe 'GET #index' do
    context 'happy path' do
      before(:all) do
        @user = User.create!(email: 'barbar@laroyaume.com', password: 'mot-de-cle')
        @phone = Phone.create!(user: @user, number: '4157451286', verified: true)
      end

      it 'returns all verified phone numbers in json' do
        get :index
        expect(response.body).to eq({'phone_numbers' => ['4157451286']}.to_json)
      end
    end

    context 'sad paths' do
      context 'when there are no numbers' do
        it 'returns an empty array' do
          get :index
          expect(response.body).to eq({'phone_numbers' => []}.to_json)
        end
      end
    end
  end
end
