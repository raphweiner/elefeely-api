require 'spec_helper'

describe PhoneNumber do
  subject do
    @user = User.create(email: 'barbar@laroyaume.com', password: 'mot de cle')
    PhoneNumber.new(user: @user, status: 'pending', number: '123145908')
  end

  it 'requires a number' do
    expect { subject.number = nil }.to change { subject.valid? }.to false
  end

  it 'requires a user' do
    expect { subject.user = nil }.to change { subject.valid? }.to false
  end

  it 'requires a unique user' do
    expect {
      PhoneNumber.create(user: @user, status: 'pending', number: '123145241412')
    }.to change { subject.valid? }.to false
  end

  it 'requires a status' do
    expect { subject.status = nil}.to change { subject.valid? }.to false
  end
end
