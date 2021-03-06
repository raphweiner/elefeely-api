class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessible :email,
                  :password

  has_one   :phone, dependent: :destroy
  has_many  :feelings, dependent: :destroy

  before_validation :set_token, on: :create

  validates_presence_of :password, on: :create
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

  def serializable_hash(options = {})
    super.tap do |data|
      data[:phone] = phone.serializable_hash(options) unless phone.nil?
    end
  end
end

