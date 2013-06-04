require 'spec_helper'

describe Phone do
  let(:user) { User.create!(email: 'barbar@laroyaume.com', password: 'mot de cle') }

  subject do
    Phone.new(user: user, number: '1234567890')
  end

  it 'requires a number' do
    expect { subject.number = nil }.to change { subject.valid? }.to false
  end

  it 'requires a number that is 10 chars long' do
    expect { subject.number = '12345' }.to change { subject.valid? }.to false
  end

  it 'requires a unique number' do
    subject.save
    user = User.create!(email: 'yo@lo.com', password: 'mot de cle')

    expect(Phone.new(user: user, number: '1234567890')).to_not be_valid
  end

  it 'requires a user' do
    expect { subject.user = nil }.to change { subject.valid? }.to false
  end

  it 'requires a true or false verified value' do
    expect { subject.verified = nil }.to change { subject.valid? }.to false
  end

  it 'requires a unique user' do
    expect {
      Phone.create(user: user, number: '1234567890')
    }.to change { subject.valid? }.to false
  end

  describe '.verified_numbers' do
    it 'scopes all verified phones' do
      subject.verified = true
      subject.save

      expect(Phone.verified_numbers).to eq [subject.number]
    end
  end

  describe '.user_by_verified_number' do
    it 'returns a user when one exists' do
      subject.verified = true
      subject.save

      expect(Phone.user_by_verified_number('1234567890')).to eq user
    end

    it 'returns nil when number is unverified' do
      subject.save

      expect(Phone.user_by_verified_number('1234567890')).to eq nil
    end

    it 'returns nil when number is not found' do
      expect(Phone.user_by_verified_number('00000')).to eq nil
    end
  end

  describe '.to_param' do
    it 'returns number' do
      expect(subject.to_param).to eq '1234567890'
    end
  end
end
