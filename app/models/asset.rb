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
      self.file_type = media.file.content_type.match(/^[a-zA-Z]*/).to_s
    end
  end

#   # a trampoline method which checks the extension before invocation
# def self.process_extensions(*args)
#   extensions = args.shift
#   args.each do |arg|
#     if arg.is_a?(Hash)
#       arg.each do |method, args|
#         processors.push([:process_trampoline, [extensions, method, args]])
#       end
#     else
#       processors.push([:process_trampoline, [extensions, arg, []]])
#     end
#   end
# end

# # our trampoline method which only performs processing if the extension matches
# def process_trampoline(extensions, method, args)
#   extension = File.extname(original_filename).downcase
#   extension = extension[1..-1] if extension[0,1] == '.'
#   self.send(method, *args) if extensions.include?(extension)
# end

end
