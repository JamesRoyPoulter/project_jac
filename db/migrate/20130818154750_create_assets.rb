class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :media
      t.string :words
      t.string :type
      t.integer :checkin_id
      t.integer :user_id
      t.integer :category_id

      t.timestamps
    end
  end
end
