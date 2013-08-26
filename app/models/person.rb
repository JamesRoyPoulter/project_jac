class Person < ActiveRecord::Base
  attr_accessible :name, :picture, :user_id

  belongs_to :user, dependent: :destroy
  has_many :checkins, through: :people_checkins

  validates_presence_of :user_id

  mount_uploader :picture, AvatarUploader

end