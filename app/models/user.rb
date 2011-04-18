class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :roles, :dependent =>:destroy
  has_many :events, :through => :roles
  
  before_save do 
    self.email.downcase! if self.email 
  end 

  def self.find_for_authentication(conditions) 
    conditions[:email].downcase! 
    super(conditions) 
  end  
end
