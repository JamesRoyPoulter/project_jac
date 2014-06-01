class Audio < Asset

  mount_uploader :media, AudioUploader

  def set_file_type
    self.file_type = 'audio'
  end

end
