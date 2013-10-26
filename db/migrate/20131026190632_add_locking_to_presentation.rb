class AddLockingToPresentation < ActiveRecord::Migration
  def self.up
  	add_column :presentations, :lock_version, :integer
  end

  def self.down
  	remove_column :presentations, :lock_version
  end
end
