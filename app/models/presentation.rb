class Presentation < ActiveRecord::Base
  belongs_to :room
  belongs_to :time_slot
end
