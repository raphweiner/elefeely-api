class ApplicationController < ActionController::API
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
    render json: { 'error' => 'unauthorized' }, status: :unauthorized
  end

  def find_user_from_token
    User.where(token: params[:token]).first if params[:token].present?
  end
end
