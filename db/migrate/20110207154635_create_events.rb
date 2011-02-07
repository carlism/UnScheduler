class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.string :site_url
      t.string :image_url

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
