class Source < ActiveRecord::Base
  attr_accessible :name,
                  :key

  before_validation :set_key, on: :create

  validates :key, presence: true,
                   uniqueness: true
  validates :name, presence: true,
                   uniqueness: true

  has_many :feelings

private

  def set_key
    self.key = SecureRandom.uuid unless name.blank?
  end
end
