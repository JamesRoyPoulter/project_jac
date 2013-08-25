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
    lat = self.latitude.to_s
    lng = self.longitude.to_s
    "http://maps.googleapis.com/maps/api/staticmap?center=" +lat + "," + lng + " &zoom=14&markers=" + lat + ","+lng + "&size=175x175&sensor=false"
  end

end
