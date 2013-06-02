class UsersController < ApplicationController
  def create
    user = User.new(params[:user])

    if user.save
      UserMailer.welcome_email(user).deliver
      auto_login(user)
      render json: session
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end
end
