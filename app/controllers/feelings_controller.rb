class FeelingsController < ApplicationController
  before_filter :find_user

  def create
    feeling = @user.feelings.build(params[:feeling])
    feeling.source = @source

    if feeling.save
      render json: { 'success' => feeling }
    else
      render json: { 'errors' => feeling.errors }
    end
  end

private

  def find_user
    @user = UserBySourceUid.find(source_name: @source.name, uid: params[:uid])
    raise ActiveRecord::RecordNotFound if @user.nil?
  end
end
