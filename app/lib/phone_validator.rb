class PhoneValidator
  def self.trigger(number)
    if number.length == 10
      request(:post, verification_number_uri, body: { number: number })
    end
  end

private

  def self.verification_number_uri
    uri '/verification'
  end

  def self.request(verb, *params)
    connection.send(verb, *params)
  end

  def self.connection
    ::Typhoeus::Request
  end

  def self.source
    @source ||= Source.where(name: 'twilio').first
  end

  def self.uri(path)
    uri = "http://elefeely-twilio-interface.herokuapp.com"
    uri << "#{path}?timestamp=#{Time.now.to_i}"
    uri << "&signature=#{signature(uri)}"
  end

  def self.signature(uri)
    OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha512'), source.secret, uri)
  end
end
