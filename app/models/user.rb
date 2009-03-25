class User < ActiveRecord::Base
  include Clearance::App::Models::User
  
  attr_accessible :admin, :judge
  
  def admin?
    self.admin
  end
  
  def judge?
  	self.judge
  end
  
  def role
  	if admin?
  	  :admin 
	elsif judge?
  	  :judge
  	else
  	  :member
  	end
  end
end