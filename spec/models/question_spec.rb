require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Question do

  it { should validate_presence_of(:name) }
  
  it "should require body on update" do
  	question = Factory(:question)
  	question.update_attribute(:body, nil)
  	question.should have(1).error_on(:body)
  end
  
  it "should create new question" do
  	lambda do
  	  Factory(:question)
  	end.should change(Question, :count)
  end 

end
