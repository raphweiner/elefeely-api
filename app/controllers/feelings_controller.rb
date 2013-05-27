class FeelingsController < ApplicationController
  before_filter :find_user

  def create
    feeling = @user.feelings.build(params)

    if feeling.save
      render json: {'success' => feeling }.to_json
    else
      render json: {'errors' => feeling.errors }.to_json
    end
  end

private

  def find_user
    @user = UserByFeelingParams.find(params)
    raise ActiveRecord::RecordNotFound if @user.nil?
  end
end
