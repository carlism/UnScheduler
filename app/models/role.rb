class Role < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  scope :admin, where("roles.role_type in (?, ?)", "creator", "admin")
  scope :creator, where(:role_type => 'creator')

end
