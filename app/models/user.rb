class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation

  has_many :checkins
  has_many :categories
  has_many :assets

end
