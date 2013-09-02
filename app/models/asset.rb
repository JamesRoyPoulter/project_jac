class Asset < ActiveRecord::Base
  attr_accessible :checkin_id, :user_id, :media, :file_type

  belongs_to :checkin
  belongs_to :user

  before_save :save_file_type

  validates :media, uniqueness: :true

  private
  def save_file_type
    if media.present? && media_changed?
      self.file_type = media.file.content_type.match(/^[a-zA-Z]*/).to_s
    end
  end
end
