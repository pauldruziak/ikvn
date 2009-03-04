require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/questions/index.html.erb" do
  include QuestionsHelper
  
  before(:each) do
    assigns[:questions] = [
      stub_model(Question,
        #:round => ,
        :name => "value for name",
        :body => "value for body"
      ),
      stub_model(Question,
        #:round => ,
        :name => "value for name",
        :body => "value for body"
      )
    ]
  end

  it "should render list of questions" do
    #render "/questions/index.html.erb"
    #response.should have_tag("tr>td", .to_s, 2)
    #response.should have_tag("tr>td", "value for name".to_s, 2)
    #response.should have_tag("tr>td", "value for body".to_s, 2)
  end
end

