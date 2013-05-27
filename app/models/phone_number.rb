class PhoneNumber < ActiveRecord::Base
  attr_accessible :number,
                  :user,
                  :status

  belongs_to :user

  validates :number, presence: true
  validates :status, presence: true
  validates :user_id, presence: true,
                      uniqueness: true
end
