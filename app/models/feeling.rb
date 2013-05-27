class Feeling < ActiveRecord::Base
  attr_accessible :source,
                  :event_id,
                  :score,
                  :user

  belongs_to :user

  validates :user_id, presence: true
  validates :source, presence: true,
                     inclusion: { in: ['twilio'] }
  validates :event_id, presence: true,
                       if: lambda { |feeling| feeling.source == 'twilio' }
  validates :score, presence: true,
                    inclusion: { in: (1..5) }
end
