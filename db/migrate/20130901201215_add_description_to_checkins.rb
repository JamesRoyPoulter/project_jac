class AddDescriptionToCheckins < ActiveRecord::Migration
  def change
    add_column :checkins, :description, :text
  end
end
