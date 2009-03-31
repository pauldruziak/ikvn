#require 'test_helper'
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')
class SeasonsControllerTest < ActionController::TestCase
  
  signed_in_admin_context do
    
  	context "on GET to :new" do
      setup { get :new }
      should_assign_to :season
      should_respond_with :success
      should_render_template :new
      should_not_set_the_flash      
    end
    

    
  
  end
end
