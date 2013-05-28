require 'spec_helper'

describe ApplicationController do
  describe '#find_source' do
    context 'happy path' do
      it 'returns the source based on source key params' do
        source = Source.create!(name: 'twilio')
        controller.params[:source_key] = source.key

        expect(controller.send(:find_source)).to eq source
      end
    end

    context 'sad path' do
      it 'returns a dummy source' do
        source = controller.send(:find_source)
        expect(source.name).to eq 'unknown'
        expect(source.key).to eq 'unknown'
      end
    end
  end
end
