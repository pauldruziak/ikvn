require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Question do
  def create_question(options={})
  	record = Question.new({ :name => "First question",
  	                        :body => "Body text"}.merge(options))
  	record.save
  	record
  end

  it "should require name" do
  	question = create_question(:name => nil)
  	question.should have(1).error_on(:name)
  end
  
  it "should require name on update" do
    question = create_question
    question.update_attribute(:name, nil)
    question.should have(1).error_on(:name)
  end
  
  it "should require body on update" do
  	question = create_question
  	question.update_attribute(:body, nil)
  	question.should have(1).error_on(:body)
  end
  
  it "should create new question" do
  	lambda do
  	  create_question
  	end.should change(Question, :count)
  end
end
