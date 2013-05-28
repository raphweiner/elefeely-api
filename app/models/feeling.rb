class Feeling < ActiveRecord::Base
  attr_accessible :score,
                  :user,
                  :source,
                  :source_event_id

  belongs_to :user
  belongs_to :source

  validates :user_id, presence: true
  validates :source_id, presence: true
  validates :source_event_id, presence: true
  validates :score, presence: true,
                    inclusion: { in: (1..5) }
end
