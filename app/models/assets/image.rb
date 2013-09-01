class Image < Asset

  belongs_to :checkin, class_name: :checkin
  before_save :set_file_type
  validates_presence_of :media

  mount_uploader :media, ImageUploader

  def set_file_type
    self.file_type = 'image'
  end

end
