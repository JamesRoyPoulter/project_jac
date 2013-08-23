class Checkin < ActiveRecord::Base

  attr_accessible :address, :category_id, :latitude, :longitude, :user_id, :title, :assets_attributes, :categories_attributes

  belongs_to :user
  belongs_to :category
  has_many :assets

  accepts_nested_attributes_for :assets
  accepts_nested_attributes_for :category

  validates_presence_of :latitude, :longitude, :title, :user_id, :category_id

  def location
    [self.latitude, self.longitude]
  end

end
