require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/questions/show.html.erb" do
  include QuestionsHelper
  before(:each) do
    assigns[:question] = @question = stub_model(Question,
      #:round => ,
      :name => "value for name",
      :body => "value for body"
    )
  end

  it "should render attributes in <p>" do
    #render "/questions/show.html.erb"
    #response.should have_text(//)
    #response.should have_text(/value\ for\ name/)
    #response.should have_text(/value\ for\ body/)
  end
end

