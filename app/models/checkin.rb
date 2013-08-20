class Checkin < ActiveRecord::Base
  attr_accessible :address, :category_id, :latitude, :longitude, :user_id, :title

  has_one :user
  has_one :category
  has_many :assets

  accepts_nested_attributes_for :assets
  accepts_nested_attributes_for :category

  validates_presence_of :latitude, :longitude, :title, :user_id, :category_id

end
