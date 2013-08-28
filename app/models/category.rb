class Category < ActiveRecord::Base
  attr_accessible :name, :user_id
  scope :current_users, -> { where(user_id: current_user) }

  belongs_to :user
  has_many :assets
  has_many :categories_checkins
  has_many :checkins, through: :categories_checkins

  validates_uniqueness_of :name, scope: :user_id
  validates_presence_of :user_id
  validates :name, length: {minimum: 3, maximum: 50 }

  def self.belonging_to user
    self.where(user_id: user.id)
  end

end
