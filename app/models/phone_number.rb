class PhoneNumber < ActiveRecord::Base
  attr_accessible :number,
                  :user,
                  :verified

  belongs_to :user

  validates :number, presence: true
  validates :user_id, presence: true,
                      uniqueness: true
end
