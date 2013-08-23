class Asset < ActiveRecord::Base
  attr_accessible :category_id, :checkin_id, :words, :user_id, :media, :file_type

  belongs_to :checkin
  belongs_to :user
  belongs_to :category

  mount_uploader :media, AssetUploader

  before_save :save_file_type
  
  private
  def save_file_type
    if media.present? && media_changed?
      self.file_type = media.file.content_type
    end
  end

end
