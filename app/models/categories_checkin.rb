class CategoriesCheckin < ActiveRecord::Base
  attr_accessible :category_id, :checkin_id
  
  belongs_to :category
  belongs_to :checkin

end
