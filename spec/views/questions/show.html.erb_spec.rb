require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/questions/show.html.erb" do
  include QuestionsHelper
  
  def mock_admin
    @admin ||= stub("user", :id => 1,
						       :login  => 'user_name',
						       :name   => 'U. Surname',
						       :to_xml => "User-in-XML", :to_json => "User-in-JSON", 
						       :errors => [], 
						       :roles  => [stub("admin", {:name => "admin", :save => true})])  
  end
  
  before(:each) do
    assigns[:question] = @question = stub("uestion",
      :round => stub("round", 
                             :name => "first",                              
                             :season => stub("season", 
                                                     :name => "1")),      
      :name => "value for name",
      :body => "value for body"
    )
  end

  it "should not render link to edit"
  
  describe "login as admin" do
    
    it "should not render link to edit"
  end
end

