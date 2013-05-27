class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessible :email,
                  :password

  has_one :phone_number

  validates_presence_of :password, on: :create
  validates :email, presence: true,
                    uniqueness: true
end

