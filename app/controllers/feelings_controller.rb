class FeelingsController < ApplicationController
  before_filter :validate_request
  before_filter :find_user

  def create
    feeling = @user.feel(feeling: params[:feeling], source: current_source)

    if feeling.save
      render json: { 'success' => feeling }
    else
      render json: { 'errors' => feeling.errors }, status: :bad_request
    end
  end

private

  def find_user
    @user = UserBySourceUid.find(source_name: current_source.name,
                                 uid: params[:uid])

    raise ActiveRecord::RecordNotFound if @user.nil?
  end
end
