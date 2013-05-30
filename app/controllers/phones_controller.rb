class PhonesController < ApplicationController
  before_filter :validate_request, only: [ :index, :update ]

  def index
    phone_numbers = Phone.verified_numbers

    render json: { 'phone_numbers' => phone_numbers }
  end

  def create
    phone = Phone.new(user: current_user, number: params[:number])

    if phone.save
      PhoneValidator.trigger(phone.number)
      render json: phone
    else
      render json: phone.errors, status: :bad_request
    end
  end

  def update
    phone = Phone.where(number: params[:number]).first || record_not_found

    if phone.update_attributes(verified: true)
      render json: phone
    else
      render json: phone.errors, status: :bad_request
    end
  end

private

  def record_not_found
    raise ActiveRecord::RecordNotFound
  end
end
