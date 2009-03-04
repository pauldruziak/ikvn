require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/questions/new.html.erb" do
  include QuestionsHelper
  
  before(:each) do
    assigns[:question] = stub_model(Question,
      :new_record? => true,
      #:round => ,
      :name => "value for name",
      :body => "value for body"
    )
  end

  it "should render new form" do
    #render "/questions/new.html.erb"
    
    #response.should have_tag("form[action=?][method=post]", questions_path) do
      #with_tag("input#question_round[name=?]", "question[round]")
      #with_tag("input#question_name[name=?]", "question[name]")
      #with_tag("textarea#question_body[name=?]", "question[body]")
    #end
  end
end


