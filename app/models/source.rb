class Source < ActiveRecord::Base
  attr_accessible :name,
                  :key,
                  :secret

  before_validation :set_credentials, on: :create

  validates :key, presence: true,
                  uniqueness: true
  validates :secret, presence: true,
                     uniqueness: true
  validates :name, presence: true,
                   uniqueness: true

  has_many :feelings

private

  def set_credentials
    self.key = SecureRandom.uuid
    self.secret = SecureRandom.uuid
  end
end
