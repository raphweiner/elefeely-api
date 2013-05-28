class ApplicationController < ActionController::API
  before_filter :find_source

private

  def find_source
    @source = Source.where(key: params[:source_key]).first ||
                OpenStruct.new(name: 'unknown', key: 'unknown')
  end
end
