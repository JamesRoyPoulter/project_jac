class AddDateToCheckin < ActiveRecord::Migration
  def change
    add_column :checkins, :date, :datetime
  end
end
