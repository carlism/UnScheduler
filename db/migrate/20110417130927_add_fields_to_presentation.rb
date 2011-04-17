class AddFieldsToPresentation < ActiveRecord::Migration
  def self.up
    add_column :presentations, :description, :text
    add_column :presentations, :format, :string
  end

  def self.down
    remove_column :presentations, :format
    remove_column :presentations, :description
  end
end