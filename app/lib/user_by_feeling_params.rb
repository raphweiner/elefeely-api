class UserByFeelingParams
  def self.find(params={})
    case params[:source]
    when 'twilio'
      Phone.user_by_verified_number(uid)
    else
     nil
    end
  end
end
