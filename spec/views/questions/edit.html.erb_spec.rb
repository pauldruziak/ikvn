require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/questions/edit.html.erb" do
  include QuestionsHelper
  
  before(:each) do
  	stubs = {
  	  :new_record? => false,
      #:round => ,
      :name => "value for name",
      :body => "value for body"
  	}
    assigns[:question] = @question = stub("question", stubs)
  end

  it "should render edit form" do
    #render "/questions/edit.html.erb"
    
    #response.should have_tag("form[action=#{question_path(@question)}][method=post]") do
      #with_tag('input#question_round[name=?]', "question[round]")
      #with_tag('input#question_name[name=?]', "question[name]")
      #with_tag('textarea#question_body[name=?]', "question[body]")
    #end
  end
end


