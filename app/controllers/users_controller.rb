class UsersController < ApplicationController
  def create
    user = User.new(params[:user])

    if user.save
      auto_login(user)
      render json: session
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end
end
