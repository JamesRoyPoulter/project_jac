class Checkin < ActiveRecord::Base

  attr_accessible :address, :latitude, :longitude, :user_id, :title,
                  :assets_attributes,
                  :categories_attributes, :categories_checkins_attributes,
                  :people_attributes, :people_checkins_attributes

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  belongs_to :user
  has_many :categories, through: :categories_checkins
  has_many :categories_checkins, dependent: :destroy
  has_many :assets, dependent: :destroy
  has_many :people, through: :people_checkins
  has_many :people_checkins, dependent: :destroy

  accepts_nested_attributes_for :assets
  accepts_nested_attributes_for :people
  accepts_nested_attributes_for :people_checkins
  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :categories_checkins

  validates_presence_of :latitude, :longitude, :title, :user_id

  def location
    [self.latitude, self.longitude]
  end

  def generate_static_url
    lat = self.latitude.to_s
    lng = self.longitude.to_s
    "http://maps.googleapis.com/maps/api/staticmap?center=" +lat + "," + lng + " &zoom=14&markers=" + lat + ","+lng + "&size=175x175&sensor=false"
  end

  def self.belonging_to user
    Checkin.where(user_id: user.id)
  end

end
