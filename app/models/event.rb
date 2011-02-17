class Event < ActiveRecord::Base
  has_many :event_dates
  has_many :roles, :dependent =>:destroy
  has_many :users, :through => :roles

  has_many :creators, :through => :roles,
           :source => :user,
           :conditions => ["roles.role_type = 'creator'"]
  # TODO:  Look up using scopes for this bit.

  has_many :admins, :through => :roles,
           :source => :user,
           :conditions => ["roles.role_type in (?, ?)", "creator", "admin"]
end
