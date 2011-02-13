class Event < ActiveRecord::Migration
  def self.up
    add_column :events, :description, :string
  end

  def self.down
    remove_column :events, :description
  end
end