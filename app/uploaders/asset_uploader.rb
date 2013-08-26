# encoding: utf-8

class AssetUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  include CarrierWave::MimeTypes
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

  # IMAGE_EXTENSIONS = %w(jpg jpeg gif png)
  # DOCUMENT_EXTENSIONS = %(exe pdf doc docm xls)
  # def extension_white_list
  #   IMAGE_EXTENSIONS + DOCUMENT_EXTENSIONS
  # end

  # process_extensions IMAGE_EXTENSIONS, :resize_to_fit => [1024, 768]


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


end
