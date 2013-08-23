class Category < ActiveRecord::Base
  attr_accessible :name, :user_id
  scope :current_users, -> { where(user_id: current_user) }

  belongs_to :user
  has_many :checkins
  has_many :assets

end
