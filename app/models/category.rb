class Category < ActiveRecord::Base
  attr_accessible :name, :user_id
  scope :current_users, -> { where(user_id: current_user) }
  before_save

  belongs_to :user
  has_many :checkins
  has_many :assets

  validates_uniqueness_of :name, scope: :user_id
  
  def capitalize_name
    name.downcase.capitalize
  end

end
