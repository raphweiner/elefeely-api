require 'spec_helper'

describe FeelingsController do
  describe 'POST #create' do
    let(:params) do
      {
        feeling: { source: 'twilio',
                   event_id: '123',
                   score: 5,
                   uid: '4157451286' }
      }
    end

    before(:all) do
      @user = User.create!(email: "rafiki@gmail.com", password: 'password')
      @phone = Phone.create!(user: @user, number: '4157451286', verified: true)
    end

    context 'happy path' do
      it 'creates a new feeling' do
        expect { post :create, params }.to change { @user.feelings.count }.by 1
      end
    end

    context 'sad path' do
      context 'user is not found' do
        before(:each) do
          params[:feeling][:uid] = '1234'
        end

        it 'does not create a new feeling' do
          expect { post :create, params }.to_not change { @user.feelings.count }
        end
      end

      context 'source is unknown' do
        before(:each) do
          params[:feeling][:source] = 'unknown'
        end

        it 'does not create a new feeling' do
          expect { post :create, params }.to_not change { @user.feelings.count }
        end
      end

      context 'source is twilio and phone is not verified' do
        before(:each) do
          phone = Phone.create!(user: @user, number: '123', verified: false)
          params[:feeling][:uid] = phone.number
        end

        it 'does not create a new feeling' do
          expect { post :create, params }.to_not change { @user.feelings.count }
        end
      end
    end
  end
end
