class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessible :email,
                  :password

  has_one   :phone
  has_many  :feelings

  before_validation :set_token, on: :create

  validates_presence_of :password, on: :create
  validates :password, length: { minimum: 6 }
  validates :email, presence: true,
                    uniqueness: true


  def feel(params)
    feelings.build(params[:feeling]).tap do |feeling|
      feeling.source = params[:source]
    end
  end

  def set_token
    self.token = SecureRandom.uuid
  end
end

