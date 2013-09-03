class User < ActiveRecord::Base
  has_secure_password

  after_create :default_category

  attr_accessible :email, :name, :password, :password_confirmation

  has_many :checkins, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :assets, dependent: :destroy
  has_many :people, dependent: :destroy

  validates :email, presence: true, uniqueness: true

  private
  def default_category
    Category.create name: "Places", color: "mint", user_id: self.id
  end

end
