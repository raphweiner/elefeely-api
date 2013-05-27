require 'spec_helper'

describe FeelingParser do
  describe '#feeling' do
    let(:params) do
      {
        source: 'twilio',
        event_id: '123',
        score: 5,
        uid: '4157451286'
      }
    end

    def feeling
      FeelingParser.new(params).feeling
    end

    context 'happy path' do
      before(:all) do
        @user = User.create!(email: "rafi@example.com", password: "password")
        @phone = Phone.create!(user: @user, number: "4157451286", verified: true)
      end

      it 'returns a valid feeling' do
        expect(feeling).to be_valid
      end
    end

    context 'sad path' do
      context 'unknown source' do
        it 'will return nil' do
          params[:source] = 'unknown'

          expect(feeling).to_not be_valid
        end
      end

      context 'unknown user' do
        it 'will return nil' do
          params[:uid] = '0000000000'

          expect(feeling).to_not be_valid
        end
      end
    end
  end
end
