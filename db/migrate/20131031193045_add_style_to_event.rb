class AddStyleToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :stylesheet, :text
  end

  def self.down
    remove_column :events, :stylesheet
  end
end
