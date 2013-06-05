class UsersController < ApplicationController
  before_filter :require_login, only: [ :me, :update ]

  def create
    user = User.new(params[:user])

    if user.save
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

  def update
    if current_user.update_attributes(params[:user])
      render json: current_user
    else
      render json: current_user.errors, status: :bad_request
    end
  end
end
