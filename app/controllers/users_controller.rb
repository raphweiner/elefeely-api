class UsersController < ApplicationController
  before_filter :require_login, only: [ :me ]

  def create
    user = User.new(params[:user])

    if user.save
      send_welcome_email(user)
      render json: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def validate_credentials
    user = login(params[:user][:email], params[:user][:password])

    if user
      render json: user
    else
      render json: {'error' => 'wrong email/password combination'},
             status: :bad_request
    end
  end

  def me
    render json: current_user
  end

private

  def send_welcome_email(user)
    UserMailer.welcome_email(user).deliver
  end
end
