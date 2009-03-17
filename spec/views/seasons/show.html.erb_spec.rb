require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/seasons/show.html.erb" do
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
    assigns[:season] = @season = stub_model(Season,
      :name => "value for name", 
      :rounds => []
    )
  end

  it "should not render link to new" do
  	render "/seasons/show.html.erb"
    response.should have_tag("ul") do
      without_tag("a", I18n.t('season.new'))
    end
  end

  
  describe "login as admin" do
    it "should render link to new" do      
      login_as mock_admin
      render "/seasons/show.html.erb"
      response.should have_tag("ul") do
    	with_tag("a", I18n.t('season.new'))
      end
    end
  end
end

