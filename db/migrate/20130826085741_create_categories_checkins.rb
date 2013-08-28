class CreateCategoriesCheckins < ActiveRecord::Migration
  def change
    create_table :categories_checkins do |t|
      t.integer :category_id
      t.integer :checkin_id

      t.timestamps
    end
    add_index :categories_checkins, :category_id
    add_index :categories_checkins, :checkin_id
  end
end
