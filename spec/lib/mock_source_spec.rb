require 'spec_helper'

describe MockSource do
  it 'behaves like a source but return nil' do
    expect(subject.name).to eq nil
    expect(subject.key).to eq nil
  end
end
