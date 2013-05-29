class FeelingsController < ApplicationController
  before_filter :validate_request
  before_filter :find_user

  def create
    feeling = @user.feelings.build(params[:feeling])
    feeling.source = current_source

    if feeling.save
      render json: { 'success' => feeling }
    else
      render json: { 'errors' => feeling.errors }, status: :bad_request
    end
  end
end
