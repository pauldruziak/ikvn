require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/rounds/show.html.erb" do
  include RoundsHelper
  before(:each) do
    assigns[:round] = @round = stub_model(Round,
      #:season => ,
      :name => "value for name",
      :published => true
    )
  end

  it "should render attributes in <p>" do
    #render "/rounds/show.html.erb"
    #response.should have_text(//)
    #response.should have_text(/value\ for\ name/)
    #response.should have_text(//)
  end
end

