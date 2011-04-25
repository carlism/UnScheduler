class CreateEventDomains < ActiveRecord::Migration
  def self.up
    create_table :domains, :force => true do |t|
      t.integer :event_id
      t.string  :domain
      t.timestamps
    end
  end

  def self.down
    drop_table :domains
  end
end