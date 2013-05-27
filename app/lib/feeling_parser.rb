class FeelingParser
  attr_reader :source,
              :score,
              :uid,
              :event_id

  def initialize(params)
    @source = params[:source]
    @event_id = params[:event_id]
    @uid = params[:uid]
    @score = params[:score]
  end

  def feeling
    Feeling.new(user: user,
                source: source,
                event_id: event_id,
                score: score)
  end

private

  def user
    case source
    when 'twilio'
      Phone.user_by_verified_number(uid)
    else
      nil
    end
  end
end
