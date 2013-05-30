require 'spec_helper'

describe PhonesController do
  describe 'GET #index' do
    context 'happy path' do
      before(:all) do
        @user = User.create!(email: 'barbar@le-royaume.com', password: 'mot-de-cle')
        @phone = Phone.create!(user: @user, number: '1234567890', verified: true)
      end

      it 'returns all verified phone numbers in json' do
        controller.stub(authorized?: true)
        get :index

        expect(response.body).to eq({'phone_numbers' => ['1234567890']}.to_json)
      end
    end

    context 'sad paths' do
      context 'when there are no numbers' do
        it 'returns an empty array' do
          controller.stub(authorized?: true)
          get :index

          expect(response.body).to eq({'phone_numbers' => []}.to_json)
        end
      end
    end
  end

  describe 'POST #create' do
    before(:each) do
      @user = User.create!(email: 'barbar@le-royaume.com', password: 'mot-de-cle')
      @params = { number: '1234567890' }
    end

    context 'happy path' do
      before(:each) do
        controller.stub(current_user: @user)
        PhoneValidator.stub(:trigger)
      end

      it 'creates a new phone associated with current user' do
        post :create, @params

        expect(@user.phone).to_not be_nil
      end

      it 'triggers phone validator to send a validating sms' do
        PhoneValidator.should_receive(:trigger).with(@params[:number])

        post :create, @params
      end

      it 'should return a 200' do
        post :create, @params
        expect(response.code).to eq '200'
      end

      it 'should return a json representation of the phone' do
        post :create, @params
        expect(response.body).to eq @user.phone.to_json
      end
    end

    context 'sad path' do
      context 'current user is nil' do
        before(:each) { post :create, @params }

        it 'throws bad request' do
          expect(response.code).to eq '400'
        end

        it 'returns errors on phone model' do
          expect(response.body).to eq({'user_id' => ["can't be blank"]}.to_json)
        end
      end

      context 'phone number is invalid' do
        before(:each) do
          controller.stub(current_user: @user)
          post :create, { number: '1234' }
        end

        it 'throws 400 when incorrect format' do
          expect(response.code).to eq '400'
        end

        it 'returns errors on phone model' do
          expect(response.body).to eq({"number" => ["is the wrong length (should be 10 characters)"]}.to_json)
        end
      end

      context 'current user already has a phone number' do
        before(:each) do
          Phone.create!(user: @user, number: '1234567890')
          controller.stub(current_user: @user)
        end

        it 'does not add phone number' do
          expect {
            post :create, { number: '0123456789' }
          }.to_not change { Phone.count }
        end

        it 'returns errors on phone model' do
          post :create, { number: '0123456789' }
          expect(response.body).to eq({"user_id" => ["has already been taken"]}.to_json)
        end
      end
    end
  end

  describe 'PUT #update' do
    before(:each) do
      @user = User.create!(email: 'barbar@le-royaume.com', password: 'mot-de-cle')
      @phone = Phone.create!(user: @user, number: '1234567890')
    end

    context 'with valid provenance' do
      before(:each) do
        controller.stub(authorized?: true)
      end

      context 'when number is found' do
        it 'updates the phone when number is found' do
          put :update, { number: '1234567890' }
          @phone.reload

          expect(@phone.verified).to eq true
        end
      end

      context 'when number is not found' do
        it 'raises record not found' do
          expect {
            put :update, { number: '000' }
          }.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end

    context 'with invalid provenance' do
      before(:each) { controller.stub(authorized?: false) }
      it 'does not look for the phone' do
        Phone.should_not_receive(:where)

        put :update, { number: '000' }
      end
    end
  end
end
