require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/seasons/show.html.erb" do
  include SeasonsHelper
  
  def mock_admin
    @admin ||= stub("user", :id => 1,
						       :login  => 'user_name',
						       :name   => 'U. Surname',
						       :to_xml => "User-in-XML", :to_json => "User-in-JSON", 
						       :errors => [], 
						       :roles  => [stub("admin", {:name => "admin", :save => true})])  
  end
  
  before(:each) do
    assigns[:season] = @season = stub("season",
      :name => "value for name", 
      :rounds => []
    )
  end

  it "should not render link to new"
  
  describe "login as admin" do
    it "should render link to new"
  end
end

