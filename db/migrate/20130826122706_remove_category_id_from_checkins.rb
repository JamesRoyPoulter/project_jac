class RemoveCategoryIdFromCheckins < ActiveRecord::Migration
  def change
    remove_column :checkins, :category_id
  end
end
