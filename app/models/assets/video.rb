class Video < Asset

  mount_uploader :media, VideoUploader

  def set_file_type
    self.file_type = 'video'
  end

end
