require 'spec_helper'

describe RequestProvenance do
  describe '.authorized?' do
    def instantiate_request
      @timestamp = Time.now.to_i.to_s
      @base_uri = 'http://localhost:3000/phones'
      @uri = @base_uri + "?source_key=#{@source.key}&timestamp=#{@timestamp}"
      @signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha512'), @source.secret, @uri)

      @params = { uri: @base_uri,
                  source: @source,
                  params: { timestamp: @timestamp,
                            source_key: @source.key,
                            signature: @signature
                          }
                 }
    end

    context 'happy path' do
      before(:all) do
        @source = Source.create!(name: 'twilio')
        instantiate_request
      end

      it 'is true with correct params' do
        expect(RequestProvenance.new(@params)).to be_authorized
      end
    end

    context 'sad path' do
      context 'with source other than twilio' do
        before(:all) do
          @source = Source.create!(name: 'twitter')
          instantiate_request
        end

        it 'returns false' do
          expect(RequestProvenance.new(@params)).to_not be_authorized
        end
      end

      context 'with incorrect signature' do
        before(:all) do
          @source = Source.create!(name: 'twilio')
          instantiate_request
          @params.merge!({params: { signature: '123' }})
        end

        it 'returns false' do
          expect(RequestProvenance.new(@params)).to_not be_authorized
        end
      end

      context 'outside of 10 seconds from timestamp' do
        before(:all) do
          @source = Source.create!(name: 'twilio')
          instantiate_request
          Time.stub(:now).and_return(OpenStruct.new(to_i: @timestamp.to_i + 10))
        end

        it 'returns false' do
          expect(RequestProvenance.new(@params)).to_not be_authorized
        end
      end
    end
  end
end
