require 'spec_helper'

describe PhoneValidator do
  describe '.trigger' do
    context 'with a valid phone number' do
      it 'triggers the number validation' do
        Source.create!(name: 'twilio')
        PhoneValidator.should_receive(:request)
        # Mike?
        PhoneValidator.trigger('1234567890')
      end
    end

    context 'with an invalid phone number' do
      it 'does not attempt to trigger the validation' do
        PhoneValidator.should_not_receive(:request)
        PhoneValidator.trigger('123456')
      end
    end
  end
end
