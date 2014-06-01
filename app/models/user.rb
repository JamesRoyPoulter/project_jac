class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me

  after_create :default_category

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
