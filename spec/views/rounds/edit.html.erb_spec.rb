require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/rounds/edit.html.erb" do
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

  it "should render edit form" do
    render "/rounds/edit.html.erb"
    
    response.should have_tag("form[action=#{season_round_path(@round.season, @round)}][method=post]") do
      with_tag('input#round_name[name=?]', "round[name]")
    end
  end
end


