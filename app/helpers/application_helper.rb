# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def if_authorized?(action, resource, &block)
    if authorized?(action, resource)
      yield action, resource
    end
  end
end
