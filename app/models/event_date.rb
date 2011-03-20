class EventDate < ActiveRecord::Base
  belongs_to :event
  validates_presence_of :event_date

  has_many :time_slots, :order => :start_time
  has_many :rooms, :order => [:position, :name]

  def build_grid
    presentations = Presentation.joins(:time_slot).
      where("time_slots.event_date_id = ?", self.id).
      includes( [:room, :time_slot] )
    presentations.inject({}) do |grid, presentation|
      grid[[presentation.time_slot.id, presentation.room.id]] = presentation
      grid
    end
  end
end
