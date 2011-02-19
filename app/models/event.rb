class Event < ActiveRecord::Base
  has_many :event_dates
  has_many :roles, :dependent =>:destroy
  has_many :users, :through => :roles

  def admin?(user)
    roles.admin.where(:user_id=>user.id).size > 0
  end

  def creator?(user)
    roles.creator.where(:user_id=>user.id).size > 0
  end
end
