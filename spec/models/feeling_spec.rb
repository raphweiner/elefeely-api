require 'spec_helper'

describe Feeling do
  subject do
    @source = Source.create!(name: 'twilio')
    @user = User.create!(email: 'barbar@afrique.com', password: 'password')
    @user.feelings.build(source: @source, source_event_id: '124', score: 5)
  end

  it 'requires a user' do
    expect { subject.user = nil }.to change { subject.valid? }.to false
  end

  it 'requires a source' do
    expect { subject.source = nil }.to change { subject.valid? }.to false
  end

  it 'requires an source_event_id when source is twilio' do
    expect { subject.source_event_id = nil }.to change { subject.valid? }.to false
  end

  it 'requires a score' do
    expect { subject.score = nil }.to change { subject.valid? }.to false
  end

  it 'requires a score between 1-5' do
    expect { subject.score = 6 }.to change { subject.valid? }.to false
  end
end
