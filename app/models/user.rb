class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessible :email,
                  :password,
                  :password_confirmation

  validates_presence_of :password, on: :create

  validates :email, presence: true,
                    uniqueness: true
end

