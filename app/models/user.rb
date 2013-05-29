class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessible :email,
                  :password

  has_one   :phone
  has_many  :feelings

  validates_presence_of :password, on: :create
  validates :email, presence: true,
                    uniqueness: true


  def feel(params)
    feelings.build(params[:feeling]).tap do |feeling|
      feeling.source = params[:source]
    end
  end
end

