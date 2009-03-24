require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/rounds/show.html.erb" do
  include RoundsHelper
  
  def mock_admin
    @admin ||= stub("user", :id => 1,
						       :login  => 'user_name',
						       :name   => 'U. Surname',
						       :to_xml => "User-in-XML", :to_json => "User-in-JSON", 
						       :errors => [], 
						       :roles  => [stub("admin", {:name => "admin", :save => true})])  
  end
  
  before(:each) do
     assigns[:round] = @round = stub("round",
      :new_record? => false,
      :season => stub("season", :name => "First"),
      :name => "1",
      :published => false, 
      :start_responses_at => Time.now,
      :end_responses_at => Time.now + 14.day,
	  :start_assess_at => Time.now + 14.day, 
  	  :end_assess_at => Time.now + 21.day
    )
  end

  it "should not render link to publish"

  
  describe "login as admin" do
    it "should render link to publish"
    
    it "should not render link to publish"
    
    it "should render link to edit"
     
    it "should not render link to edit"
    
  end
end

