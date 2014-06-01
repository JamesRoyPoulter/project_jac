class Category < ActiveRecord::Base
  attr_accessible :name, :user_id, :color
  scope :current_users, -> { where(user_id: current_user) }
  validate :validate_color

  belongs_to :user
  has_many :categories_checkins
  has_many :checkins, through: :categories_checkins

  validates_uniqueness_of :name, scope: :user_id
  validates_presence_of :user_id
  validates :name, length: {minimum: 3, maximum: 50 }

  def self.belonging_to user
    self.where(user_id: user.id)
  end

  def self.colors
    self.available_colors.map { |x| [x.capitalize,x] }
  end

  def self.available_colors
    [
     'aqua','black','blue','coral','green',
     'mint','pink','purple','red','yellow'
    ]
  end

  def validate_color
    if !Category.available_colors.include? self.color
      errors.add(:color, 'is an unavailable color')
    end
  end

end
