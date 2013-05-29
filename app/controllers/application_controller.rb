class ApplicationController < ActionController::API

  def current_user
    # sorcery
  end

private

  def validate_request
    signature = params[:signature]

    uri = current_path + "?source_key=#{params[:source_key]}&timestamp=#{params[:timestamp]}"

    answer = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'),
                                     current_source.secret,
                                     uri)

    unless answer == signature && (Time.now.to_i - params[:timestamp].to_i) < 10 && current_source.name == 'twilio'
      unauthorized
    end
  end

  def current_path
    "#{request.protocol}#{request.host_with_port}#{request.path}"
  end

  def find_user
    @user = UserBySourceUid.find(source_name: current_source.name,
                                 uid: params[:uid])

    raise ActiveRecord::RecordNotFound if @user.nil?
  end

  def current_source
    @source ||= Source.where(key: params[:source_key]).first || unauthorized
  end

  def unauthorized
    render json: [], status: :unauthorized
  end
end
