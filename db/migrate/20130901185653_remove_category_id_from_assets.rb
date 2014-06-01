class RemoveCategoryIdFromAssets < ActiveRecord::Migration
  def change
    remove_column :assets, :category_id
  end
end
