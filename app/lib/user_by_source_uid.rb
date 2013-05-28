class UserBySourceUid
  def self.find(params={})
    case params[:source_name]
    when 'twilio' then Phone.user_by_verified_number(params[:uid])
    else nil
    end
  end
end
