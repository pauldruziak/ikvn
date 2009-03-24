require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/rounds/edit.html.erb" do
  include RoundsHelper
  
  before(:each) do
    assigns[:round] = @round = stub("round",
      :new_record? => false,
      :season => stub("season", :name => "First", :rounds => []),
      :name => "1",
      :published => false, 
      :start_responses_at => Time.now,
      :end_responses_at => Time.now + 14.day,
	  :start_assess_at => Time.now + 14.day, 
  	  :end_assess_at => Time.now + 21.day, 
  	  :errors => []  	  
    )
  end

  it "should render edit form"
end


