class Asset < ActiveRecord::Base
  attr_accessible :category_id, :checkin_id, :words, :user_id, :media, :type

  belongs_to :checkin
  belongs_to :user
  belongs_to :category
  
  mount_uploader :media, AssetUploader

end
