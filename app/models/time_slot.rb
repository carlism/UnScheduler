class TimeSlot < ActiveRecord::Base
  belongs_to :event_date
  has_many :presentations, :dependent => :destroy
  
  DISPLAY_FORMAT = "%I:%M %p"
  
  def formatted_start_time
    start_time.strftime(DISPLAY_FORMAT) if start_time
  end
  
  def formatted_start_time=(input)
     self.start_time = input
  end
end
