require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/questions/show.html.erb" do
  include QuestionsHelper
  
  def mock_admin
    @admin ||= mock_model(User, :id => 1,
						       :login  => 'user_name',
						       :name   => 'U. Surname',
						       :to_xml => "User-in-XML", :to_json => "User-in-JSON", 
						       :errors => [], 
						       :roles  => [mock_model(Role, {:name => "admin", :save => true})])  
  end
  
  before(:each) do
    assigns[:question] = @question = stub_model(Question,
      :round => stub_model(Round, 
                             :name => "first",                              
                             :season => stub_model(Season, 
                                                     :name => "1")),      
      :name => "value for name",
      :body => "value for body"
    )
  end

  it "should not render link to edit" do
  	render "/questions/show.html.erb"
    response.should have_tag("ul") do
      without_tag("a", I18n.t('question.edit'))
    end
  end

  
  describe "login as admin" do
    it "should render link to edit" do      
      login_as mock_admin
      template.should_receive(:authorized?).and_return(true)
      render "/questions/show.html.erb"
      response.should have_tag("ul") do
    	with_tag("a", I18n.t('question.edit'))
      end
    end
    
    it "should not render link to edit" do
      login_as mock_admin
      template.should_receive(:authorized?).and_return(false)
      render "/questions/show.html.erb"
      response.should have_tag("ul") do
    	without_tag("a", I18n.t('question.edit'))
      end
    end
  end
end

