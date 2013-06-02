class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::Helpers
  include Sorcery::Controller

private

  def require_authenticated_source
    unauthorized unless authorized?
  end

  def authorized?
    request_provenance = RequestProvenance.new( uri: current_uri,
                                                source: current_source,
                                                params: params )
    request_provenance.authorized?
  end

  def current_uri
    "#{request.protocol}#{request.host_with_port}#{request.path}"
  end

  def current_source
    @source ||= Source.where(key: params[:source_key]).first
  end

  def unauthorized
    # how to return here? need to stop execution
    # otherwise NoMethodError (undefined method `secret' for ["{\"error\":\"unauthorized\"}"]:Array):
    # in app/lib/request_provenance.rb:26:in `answer'
    render json: { 'error' => 'unauthorized' }, status: :unauthorized
  end
end
