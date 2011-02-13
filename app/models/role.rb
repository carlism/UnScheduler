class Role < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  CREATOR_ROLE = 1
  ADMIN_ROLE = 2
  SPONSOR_ROLE = 3
  VOLUNTEER_ROLE = 4
  PARTICIPANT_ROLE = 5
end
