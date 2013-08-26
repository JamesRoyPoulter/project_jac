class CreatePeopleCheckins < ActiveRecord::Migration
  def change
    create_table :people_checkins do |t|
      t.integer :person_id
      t.integer :checkin_id

      t.timestamps
    end
  end
end
