require 'spec_helper'

describe FeelingsController do
  describe 'POST #create' do
    before(:each) do
      @source = Source.create!(name: 'twilio')
      @user = User.create!(email: "rafiki@gmail.com", password: 'password')
      @phone = Phone.create!(user: @user, number: '4157451286', verified: true)
      @params = {
                  source_key: @source.key,
                  uid: @phone.number,
                  feeling: {
                             source_event_id: '123',
                             score: 5 }}

      controller.stub(:validate_request).and_return(true)
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
      context 'user is not found' do
        it 'raises a record not found exception' do
          @params[:uid] = '1234'

          expect { post :create, @params }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      context 'user is found but params are incorrect' do
        it 'responds with bad request code (400)' do
          post :create, { source_key: @source.key, uid: '4157451286' }

          expect(response.code).to eq '400'
        end
      end

      context 'source is not authorized' do
        it 'responds with unauthorized code (401)' do
          controller.rspec_reset
          post :create, @params

          expect(response.code).to eq '401'
        end
      end
    end
  end
end
