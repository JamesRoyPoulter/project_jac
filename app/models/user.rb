class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :name, :password, :password_confirmation

  has_many :checkins, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :assets, dependent: :destroy
  has_many :people, dependent: :destroy

  validates :email, presence: true, uniqueness: true

end
