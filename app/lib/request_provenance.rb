class RequestProvenance
  attr_reader :base_uri,
              :source,
              :params

  def initialize(params)
    @base_uri = params[:uri]
    @source = params[:source]
    @params = params[:params]
  end

  def authorized?
    source && valid_signature? && valid_timestamp? && valid_source_name?
  end

private

  def uri
    base_uri + "?source_key=#{params[:source_key]}&timestamp=#{params[:timestamp]}"
  end

  def answer
    OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha512'),
                            source.secret,
                            uri)
  end

  def signature
    params[:signature]
  end

  def valid_signature?
    answer == signature
  end

  def valid_timestamp?
    (Time.now.to_i - params[:timestamp].to_i) < 10
  end

  def valid_source_name?
    source.name == 'twilio'
  end
end
