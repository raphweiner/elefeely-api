class FeelingsController < ApplicationController
  # before_filter :require_authenticated_source, only: [ :create ]
  before_filter :find_user, only: [:create]
  before_filter :require_login, only: [:me]

  def create
    feeling = @user.feel(feeling: params[:feeling], source: current_source)

    if feeling.save
      trigger_feelings_pusher(feeling)
      render json: { 'success' => feeling }
    else
      render json: { 'errors' => feeling.errors }, status: :bad_request
    end
  end

  def index
    render json: Feeling.all
  end

  def me
    render json: current_user.feelings
  end

private

  def trigger_feelings_pusher(feeling)
    Pusher['feelings'].trigger('new_feeling', feeling)
  end

  def find_user
    @user = current_user || UserBySourceUid.find(source_name: current_source.name,
                                                 uid: params.delete(:uid))

    raise ActiveRecord::RecordNotFound if @user.nil?
  end
end
