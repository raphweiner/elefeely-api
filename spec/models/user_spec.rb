require 'spec_helper'

describe User do
  subject do
    User.new(email: 'rafi@example.com', password: 'omgyup')
  end

  it 'requires an email' do
    expect { subject.email = nil }.to change { subject.valid? }.to false
  end

  it 'requires a unique email' do
    expect {
      User.create(email: 'rafi@example.com', password: 'yupyup')
    }.to change { subject.valid? }.to false
  end

  it 'requires a password' do
    expect { subject.password = nil }.to change { subject.valid? }.to false
  end

  it 'sets token upon creation' do
    expect { subject.save }.to change { subject.token }
  end

  describe '.feel' do
    let(:params) { { feeling: {score: 4, source_event_id: '123'}, source: Source.create!(name: 'twilio') } }

    context 'with valid params and source' do
      it 'returns a valid feeling' do
        subject.save

        expect(subject.feel(params)).to be_an_instance_of Feeling
        expect(subject.feel(params)).to be_valid
      end
    end

    context 'without a source' do
      it 'returns an invalid feeling' do
        subject.save

        expect(subject.feel(params.except(:source))).to_not be_valid
      end
    end

    context 'with missing parameters' do
      it 'returns an invalid feeling' do
        expect(subject.feel(params)).to_not be_valid
      end
    end
  end

  describe '.to_json' do
    it 'includes phone if associated exists' do
      subject.save
      Phone.create!(number: '1231231231', user: subject)

      expect(subject.to_json).to include('phone')
    end

    it 'does not include phone record if none is associated' do
      expect(subject.to_json).to_not include('phone')
    end
  end
end
