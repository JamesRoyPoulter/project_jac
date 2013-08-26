class Person < ActiveRecord::Base
  attr_accessible :name, :picture, :user_id

  belongs_to :user, dependent: :destroy
  has_many :people_checkins
  has_many :checkins, through: :people_checkins

  validates_presence_of :user_id
  validates_uniqueness_of :name, scope: :user_id

  mount_uploader :picture, AvatarUploader

end
