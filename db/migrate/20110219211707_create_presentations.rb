class CreatePresentations < ActiveRecord::Migration
  def self.up
    create_table :presentations do |t|
      t.string :title
      t.string :presenter
      t.string :contact
      t.integer :room_id
      t.integer :time_slot_id

      t.timestamps
    end
    add_index(:presentations, [:room_id, :time_slot_id], :unique=>true)
  end

  def self.down
    drop_table :presentations
  end
end
