class EventDate < ActiveRecord::Base
  belongs_to :event
  validates_presence_of :event_date

  has_many :time_slots
  has_many :rooms
end
