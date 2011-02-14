class CreateEventDates < ActiveRecord::Migration
  def self.up
    create_table :event_dates do |t|
      t.references :event
      t.date :event_date

      t.timestamps
    end
  end

  def self.down
    drop_table :event_dates
  end
end
