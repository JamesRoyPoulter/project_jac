class Checkin < ActiveRecord::Base

  attr_accessible :address, :category_id, :latitude, :longitude, :user_id, :title,
                  :assets_attributes, :category_attributes

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  belongs_to :user
  belongs_to :category
  has_many :assets

  accepts_nested_attributes_for :assets
  accepts_nested_attributes_for :category

  validates_presence_of :latitude, :longitude, :title, :user_id, :category_id

  def location
    [self.latitude, self.longitude]
  end

  def generate_static_url
    "http://maps.google.com/maps/api/staticmap?markers=label:X|" + latitude + ","+longitude + "&size=200x200&sensor=TRUE_OR_FALSE"
  end

end
