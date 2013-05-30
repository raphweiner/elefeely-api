class PhoneValidator
  def self.trigger(number)
    if number.length == 10
      request(:post, validate_number_uri, body: { number: number })
    end
  end

private

  def self.validate_number_uri
    uri '/validation'
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
    OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), source.secret, uri)
  end
end
