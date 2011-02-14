class Event < ActiveRecord::Base
  has_many :event_dates
  has_many :roles, :dependent =>:destroy
  has_many :users, :through => :roles

  has_many :creators, :through => :roles,
           :source => :user,
           :conditions => "role_type=#{Role::CREATOR_ROLE}"
  has_many :admins, :through => :roles,
           :source => :user,
           :conditions => "role_type=#{Role::CREATOR_ROLE} or role_type=#{Role::ADMIN_ROLE}"
  
end
