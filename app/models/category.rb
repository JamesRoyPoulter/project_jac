class Category < ActiveRecord::Base
  attr_accessible :name, :user_id, :color
  scope :current_users, -> { where(user_id: current_user) }
  validate :validate_color

  belongs_to :user
  has_many :assets
  has_many :categories_checkins
  has_many :checkins, through: :categories_checkins

  validates_uniqueness_of :name, scope: :user_id
  validates_presence_of :user_id
  validates :name, length: {minimum: 3, maximum: 50 }

  def self.belonging_to user
    self.where(user_id: user.id)
  end

  def self.colors
    [['Coral','coral'],['Crimson','crimson'],['Green','green'],['Mustard','mustard'],['Pink','pink'],['Purple','purple'],['Red','red']]
  end

  def available_colors
    ['aqua','coral','crimson','green','light_blue','light_pink','mint','mustard','pink',
     'purple','red']
  end

  def validate_color
    if !available_colors.include? self.color
      errors.add(:color, 'is an unavailable color')
    end
  end

end
