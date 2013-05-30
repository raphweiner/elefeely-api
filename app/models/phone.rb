class Phone < ActiveRecord::Base
  attr_accessible :number,
                  :user,
                  :verified

  belongs_to :user

  validates :number, presence: true,
                     length: { is: 10 }
  validates :user_id, presence: true,
                      uniqueness: true

  scope :verified, where(verified: true)

  def to_param
    number
  end

  def self.verified_numbers
    verified.pluck(:number)
  end

  def self.user_by_verified_number(number)
    verified.where(number: number).map(&:user).first
  end
end
