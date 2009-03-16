require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
include AuthenticatedSystem
describe "/seasons/index.html.erb" do
  include SeasonsHelper
  def mock_admin
    @admin ||= mock_model(User, :id => 1,
						       :login  => 'user_name',
						       :name   => 'U. Surname',
						       :to_xml => "User-in-XML", :to_json => "User-in-JSON", 
						       :errors => [], 
						       :roles  => [mock_model(Role, {:name => "admin", :save => true})])  
  end
  before(:each) do
    assigns[:seasons] = [
      stub_model(Season,
        :name => "value for name"
      ),
      stub_model(Season,
        :name => "value for name"
      )
    ]
  end

  it "should render list of seasons" do
    render "/seasons/index.html.erb"
    response.should have_tag("h2", "Season: value for name".to_s, 2)
  end
  
  it "should not render link to new" do
  	render "/seasons/index.html.erb"
    response.should have_tag("ul") do
      without_tag("a", "New season")
    end
  end

  
  describe "login as admin" do
    it "should render link to new" do      
      login_as mock_admin
      render "/seasons/index.html.erb"
      response.should have_tag("ul") do
    	with_tag("a", "New season")
      end
    end
  end
end

