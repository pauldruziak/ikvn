require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/rounds/show.html.erb" do
  include RoundsHelper
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

  it "should render attributes in <p>" do
    render "/rounds/show.html.erb"
    response.should have_text(//)
    response.should have_text(/1/)
    response.should have_text(//)
  end
end

