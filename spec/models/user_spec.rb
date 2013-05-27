require 'spec_helper'

describe User do
  subject do
    User.new(email: 'rafi@example.com', password: 'omg!')
  end

  it 'requires an email' do
    expect { subject.email = nil }.to change { subject.valid? }.to false
  end

  it 'requires a unique email' do
    expect { User.create(email: 'rafi@example.com', password: 'yup') }
      .to change { subject.valid? }.to false
  end

  it 'requires a password' do
    expect { subject.password = nil }.to change { subject.valid? }.to false
  end
end
