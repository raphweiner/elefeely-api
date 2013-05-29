require 'spec_helper'

describe UserBySourceUid do
  before(:each) do
    @source = Source.create!(name: 'twilio')
  end

  describe '.find' do
    context 'with valid source and existing uid' do
      before(:all) do
        @user = User.create!(email: "rafi@example.com", password: "password")
        @phone = Phone.create!(user: @user, number: "4157451286", verified: true)
      end

      it 'returns a valid user' do
        expect(UserBySourceUid.find(source_name: @source.name, uid: '4157451286')).to eq @user
      end
    end

    context 'on the sad path with' do
      context 'unknown source' do
        it 'does not find the user and returns nil' do
          expect(UserBySourceUid.find(source_name: 'unknown', uid:'4157451286')).to eq nil
        end
      end

      context 'unknown user' do
        it 'does not find the user and returns nil' do
          expect(UserBySourceUid.find(source_name: 'unknown', uid:'0000000')).to eq nil
        end
      end
    end
  end
end
