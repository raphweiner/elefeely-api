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
    @source ||= Source.where(key: params[:source_key]).first || unauthorized
  end

  def unauthorized
    render json: { 'error' => 'unauthorized' }, status: :unauthorized
  end
end
