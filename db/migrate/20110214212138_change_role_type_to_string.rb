class ChangeRoleTypeToString < ActiveRecord::Migration
  def self.up
    add_column :roles, :type_name, :string
    Role.reset_column_information
    Role.update_all("type_name = 'creator'",     "role_type = 1")
    Role.update_all("type_name = 'admin'",       "role_type = 2")
    Role.update_all("type_name = 'sponsor'",     "role_type = 3")
    Role.update_all("type_name = 'volunteer'",   "role_type = 4")
    Role.update_all("type_name = 'participant'", "role_type = 5")
    remove_column :roles, :role_type
    rename_column :roles, :type_name, :role_type
  end

  def self.down
    rename_column :roles, :role_type, :type_name
    add_column :roles, :role_type, :integer
    Role.reset_column_information
    Role.update_all("role_type = 1", "type_name = 'creator'")
    Role.update_all("role_type = 2", "type_name = 'admin'" )
    Role.update_all("role_type = 3", "type_name = 'sponsor'" )
    Role.update_all("role_type = 4", "type_name = 'volunteer'" )
    Role.update_all("role_type = 5", "type_name = 'participant'" )
    remove_column :roles, :type_name
  end
end
