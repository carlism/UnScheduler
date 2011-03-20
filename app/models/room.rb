class Room < ActiveRecord::Base
  belongs_to :event_date
  has_many :presentations, :dependent => :destroy
end
