require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/rounds/edit.html.erb" do
  include RoundsHelper
  
  before(:each) do
    assigns[:round] = @round = stub_model(Round,
      :new_record? => false,
      #:season => ,
      :name => "value for name",
      :published => true
    )
  end

  it "should render edit form" do
    #render "/rounds/edit.html.erb"
    
    #response.should have_tag("form[action=#{round_path(@round)}][method=post]") do
     # with_tag('input#round_season[name=?]', "round[season]")
      #with_tag('input#round_name[name=?]', "round[name]")
      #with_tag('input#round_published[name=?]', "round[published]")
   # end
  end
end


