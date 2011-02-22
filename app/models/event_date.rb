class EventDate < ActiveRecord::Base
  belongs_to :event
  validates_presence_of :event_date

  has_many :time_slots
  has_many :rooms

  def build_grid
    grid = {}
    time_slots.each do |time_slot|
      time_slot.presentations do |presentation|
        room = presentation.room
        grid["#{time_slots.id}.#{room.id}"] = presentation
      end
    end
    grid
  end
end
