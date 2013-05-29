class RequestProvenance
  attr_reader :path,
              :source,
              :params

  def initialize(params)
    @path = params[:path]
    @source = params[:source]
    @params = params[:params]
  end

  def authorized?
    answer == signature &&
      (Time.now.to_i - params[:timestamp].to_i) < 10 &&
      source.name == 'twilio'
  end

private

  def uri
    path + "?source_key=#{params[:source_key]}&timestamp=#{params[:timestamp]}"
  end

  def answer
    OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'),
                            source.secret,
                            uri)
  end

  def signature
    params[:signature]
  end
end
