class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.text :title, default: ''
      t.integer :user_id, null: false
      t.integer :category_id, null: false
      t.string :address

      t.timestamps
    end
  end
end
