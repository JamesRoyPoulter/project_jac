# encoding: utf-8

class AssetUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  include CarrierWave::MimeTypes
  include CarrierWave::Video
  include CarrierWave::Video::Thumbnailer
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  version :video_thumb, :if => :video? do
    process thumbnail: [{format: 'jpg', quality: 10, size: 192, strip: true, logger: Rails.logger}]
    def full_filename for_file
      png_name for_file, version_name
    end
  end

  def png_name for_file, version_name
    %Q{#{version_name}_#{for_file.chomp(File.extname(for_file))}.jpg}
  end


  # CALL METHOD TO SET CONTENT TYPE
  process :set_content_type

  # Create different versions of your uploaded files:
  version :thumb, :if => :image? do
    process :resize_to_fill => [50, 50]
  end

  version :show_checkin, :if => :image? do
    process :resize_to_fill => [175, 175]
  end

  def extension_white_list
    %w(jpg jpeg gif png mp4 3gp mp3 aac wav mid mov m4a)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  protected
  def image?(new_file)
    new_file.content_type.start_with? 'image'
  end

  def video?(new_file)
    new_file.content_type.start_with? 'video'
  end

end
