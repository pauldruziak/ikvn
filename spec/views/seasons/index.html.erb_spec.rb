require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/seasons/index.html.erb" do
  include SeasonsHelper
  
  before(:each) do
    assigns[:seasons] = [
      stub_model(Season,
        :name => "value for name"
      ),
      stub_model(Season,
        :name => "value for name"
      )
    ]
  end

  it "should render list of seasons" do
    render "/seasons/index.html.erb"
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end

