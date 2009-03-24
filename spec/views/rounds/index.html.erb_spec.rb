require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/rounds/index.html.erb" do
  include RoundsHelper
  
  before(:each) do
    assigns[:rounds] = [
      stub("round1",
        #:season => ,
        :name => "value for name",
        :published => true
      ),
      stub("round2",
        #:season => ,
        :name => "value for name",
        :published => true
      )
    ]
  end

  it "should render list of rounds" do
    #render "/rounds/index.html.erb"
    #response.should have_tag("tr>td", .to_s, 2)
    #response.should have_tag("tr>td", "value for name".to_s, 2)
   # response.should have_tag("tr>td", .to_s, 2)
  end
end

