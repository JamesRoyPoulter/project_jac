class Image < Asset

  mount_uploader :media, ImageUploader

  def set_file_type
    self.file_type = 'image'
  end

end
