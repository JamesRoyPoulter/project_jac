class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :name, :password, :password_confirmation

  has_many :checkins
  has_many :categories
  has_many :assets

  validates :email, presence: true, uniqueness: true

end
