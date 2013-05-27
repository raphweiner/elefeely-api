require 'spec_helper'

describe Phone do
  subject do
    @user = User.create!(email: 'barbar@laroyaume.com', password: 'mot de cle')
    Phone.new(user: @user, number: '123145908')
  end

  it 'requires a number' do
    expect { subject.number = nil }.to change { subject.valid? }.to false
  end

  it 'requires a user' do
    expect { subject.user = nil }.to change { subject.valid? }.to false
  end

  it 'requires a unique user' do
    expect {
      Phone.create(user: @user, number: '123145241412')
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

      expect(Phone.user_by_verified_number('123145908')).to eq @user
    end

    it 'returns nil when number is unverified' do
      subject.save
      expect(Phone.user_by_verified_number('123145908')).to eq nil
    end

    it 'returns nil when number is not found' do
      expect(Phone.user_by_verified_number('00000')).to eq nil
    end
  end
end