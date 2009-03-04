require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/seasons/show.html.erb" do
  include SeasonsHelper
  before(:each) do
    assigns[:season] = @season = stub_model(Season,
      :name => "value for name"
    )
  end

  it "should render attributes in <p>" do
    #render "/seasons/show.html.erb"
    #response.should have_text(/value\ for\ name/)
  end
end

