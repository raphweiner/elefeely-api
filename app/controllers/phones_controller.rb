class PhonesController < ApplicationController
  def verified
    phone_numbers = Phone.verified_numbers

    render json: {'phone_numbers' => phone_numbers}
  end
end
