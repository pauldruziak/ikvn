module SeasonsHelper
  def authorized?(action, resource)
  	action == :new && logged_in? && current_user.has_role?("admin")
  end
  
  def seasons
  	Season.find(:all, :order => "id DESC")
  end
end
