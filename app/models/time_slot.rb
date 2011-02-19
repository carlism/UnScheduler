class TimeSlot < ActiveRecord::Base
  belongs_to :event_date
  has_many :presentations
end
