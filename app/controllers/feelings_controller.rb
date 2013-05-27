class FeelingsController < ApplicationController
  def create
    feeling = FeelingParser.new(params).feeling

    if feeling.save
      render json: {'success' => feeling }.to_json
    else
      render json: {'errors' => feeling.errors }.to_json
    end
  end
end
