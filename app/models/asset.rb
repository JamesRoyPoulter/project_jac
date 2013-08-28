class Asset < ActiveRecord::Base
  attr_accessible :category_id, :checkin_id, :words, :user_id, :media, :file_type

  belongs_to :checkin
  belongs_to :user
  belongs_to :category

  mount_uploader :media, AssetUploader

  before_save :save_file_type

  validates :media, uniqueness: :true

  private
  def save_file_type
    if media.present? && media_changed?
      self.file_type = media.file.content_type.match(/^[a-zA-Z]*/).to_s
    else
      self.file_type = 'text'
    end
  end

end
