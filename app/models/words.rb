class Words < Asset
  before_save :set_file_type
  validates_presence_of :words

  def set_file_type
    self.file_type = 'text'
  end
end
