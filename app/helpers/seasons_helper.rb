module SeasonsHelper
  def authorized?(action, resource)
  	action == :new && logged_in? && current_user.has_role?("admin")
  end
end
