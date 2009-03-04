require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/rounds/new.html.erb" do
  include RoundsHelper
  
  before(:each) do
    assigns[:round] = stub_model(Round,
      :new_record? => true,
      #:season => ,
      :name => "value for name",
      :published => true
    )
  end

  it "should render new form" do
    #render "/rounds/new.html.erb"
    
    #response.should have_tag("form[action=?][method=post]", rounds_path) do
      #with_tag("input#round_season[name=?]", "round[season]")
      #with_tag("input#round_name[name=?]", "round[name]")
      #with_tag("input#round_published[name=?]", "round[published]")
   # end
  end
end


