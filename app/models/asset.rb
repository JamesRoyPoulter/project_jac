class Asset < ActiveRecord::Base
  attr_accessible :checkin_id, :user_id, :media, :file_type

  before_save :set_file_type
  belongs_to :checkin
  belongs_to :user

  # validates :media, uniqueness: true, presence: true

end
