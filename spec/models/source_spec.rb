require 'spec_helper'

describe Source do
  subject do
    Source.new(name: 'twilio')
  end

  it 'requires a name' do
    expect { subject.name = nil }.to change { subject.valid? }.to false
  end

  it 'requires unique a name' do
    subject.save

    expect { Source.create!(name: 'twilio') }.to raise_error
  end

  it 'requires a key' do
    subject.save

    expect { subject.key = nil }.to change { subject.valid? }.to false
  end

  it 'assigns the key upon creation' do
    source = Source.new(name: 'hello')
    expect { source.save }.to change { source.key }
  end
end
