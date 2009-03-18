require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/rounds/show.html.erb" do
  include RoundsHelper
  
  def mock_admin
    @admin ||= mock_model(User, :id => 1,
						       :login  => 'user_name',
						       :name   => 'U. Surname',
						       :to_xml => "User-in-XML", :to_json => "User-in-JSON", 
						       :errors => [], 
						       :roles  => [mock_model(Role, {:name => "admin", :save => true})])  
  end
  
  before(:each) do
     assigns[:round] = @round = stub_model(Round,
      :new_record? => false,
      :season => stub_model(Season, :name => "First"),
      :name => "1",
      :published => false, 
      :start_responses_at => Time.now,
      :end_responses_at => Time.now + 14.day,
	  :start_assess_at => Time.now + 14.day, 
  	  :end_assess_at => Time.now + 21.day
    )
  end

  it "should not render link to publish" do
  	render "/rounds/show.html.erb"
    response.should have_tag("ul") do
      without_tag("a", I18n.t('round.publish'))
    end
  end

  
  describe "login as admin" do
    it "should render link to publish" do      
      login_as mock_admin
      template.should_receive(:authorized?).with(:publish, @round).and_return(true)
      render "/rounds/show.html.erb"
      response.should have_tag("ul") do
    	with_tag("a", I18n.t('round.publish'))
      end
    end
    
    it "should not render link to publish" do
      login_as mock_admin
      template.should_receive(:authorized?).with(:publish, @round).and_return(false)
      render "/rounds/show.html.erb"
      response.should have_tag("ul") do
    	without_tag("a", I18n.t('round.publish'))
      end
    end
  end
end

