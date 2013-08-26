class PeopleCheckin < ActiveRecord::Base
  attr_accessible :checkin_id, :person_id

  belongs_to :checkin
  belongs_to :person
end
