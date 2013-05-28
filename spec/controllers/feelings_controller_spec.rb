require 'spec_helper'

describe FeelingsController do
  describe 'POST #create' do
    before(:each) do
      @source = Source.create!(name: 'twilio')
      @user = User.create!(email: "rafiki@gmail.com", password: 'password')
      @phone = Phone.create!(user: @user, number: '4157451286', verified: true)
      @params = {
                  source_key: @source.key,
                  uid: '4157451286',
                  feeling: {
                             source_event_id: '123',
                             score: 5
                           }
                }
    end

    context 'happy path' do
      it 'creates a new feeling' do
        expect { post :create, @params }.to change { @user.feelings.count }.by 1
      end

      it 'responds with created feeling' do
        post :create, @params

        expect(response.body).to eq({'success' => @user.feelings.first}.to_json)
      end
    end

    context 'sad path' do
      context 'user is found but params are incorrect' do
        it 'responds with correct errors' do
          post :create, { source_key: @source.key, uid: '4157451286' }

          feeling = @user.feelings.create(source: @source)
          expect(response.body).to eq({'errors' => feeling.errors}.to_json)
        end
      end

      context 'user is not found' do
        it 'raises a record not found exception' do
          @params[:uid] = '1234'
          expect { post :create, @params }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      # context 'source is unknown' do
      #   before(:each) do
      #     params[:source] = 'unknown'
      #   end

      #   it 'does not create a new feeling' do
      #     expect { post :create, params }.to_not change { @user.feelings.count }
      #   end
      # end

      # context 'source is twilio and phone is not verified' do
      #   it 'does not create a new feeling' do
      #     user = User.create!(email: 'somone@example.com', password: 'pass')
      #     phone = Phone.create!(user: user, number: '123', verified: false)
      #     params[:uid] = phone.number

      #     expect { post :create, params }.to_not change { user.feelings.count }
      #   end
      # end
    end
  end
end
