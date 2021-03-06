class Event < ActiveRecord::Base
  has_many :event_dates, :order=>:event_date
  has_many :roles, :dependent =>:destroy
  has_many :users, :through => :roles
  has_many :domains

  def admin?(user)
    user && roles.admin.where(:user_id=>user.id).size > 0
  end

  def creator?(user)
    user && roles.creator.where(:user_id=>user.id).size > 0
  end
  
  def self.find_by_host(host)
    Event.joins(:domains).where('domains.domain'=>host).includes(:event_dates).first
  end
end
