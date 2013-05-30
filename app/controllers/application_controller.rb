class ApplicationController < ActionController::API

  def current_user
    # sorcery
  end

private

  def validate_request
    unauthorized unless authorized?
  end

  def authorized?
    request_provenance = RequestProvenance.new( path: current_path,
                                                source: current_source,
                                                params: params )
    request_provenance.authorized?
  end

  def current_path
    "#{request.protocol}#{request.host_with_port}#{request.path}"
  end

  def current_source
    raise "sym: #{params[:source_key].inspect}, string: #{params['source_key'].inspect}"
    @source ||= Source.where(key: params[:source_key]).first || unauthorized
  end

  def unauthorized
    # how to return here? need to stop execution
    # otherwise NoMethodError (undefined method `secret' for ["{\"error\":\"unauthorized\"}"]:Array):
    # in app/lib/request_provenance.rb:26:in `answer'
    render json: { 'error' => 'unauthorized' }, status: :unauthorized
  end
end
