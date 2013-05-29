class PhonesController < ApplicationController
  before_filter :validate_request

  def index
    phone_numbers = Phone.verified_numbers

    render json: {'phone_numbers' => phone_numbers}
  end
end
