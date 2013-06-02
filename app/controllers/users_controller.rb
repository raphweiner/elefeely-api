class UsersController < ApplicationController
  def create
    user = User.new(params[:user])

    if user.save
      send_welcome_email(user)
      render json: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

private

  def send_welcome_email(user)
    UserMailer.welcome_email(user).deliver
  end
end
