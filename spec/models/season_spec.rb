require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Season do
  before(:each) do    
    @season = Season.new
  end
  
  it "should require name" do
    @season.should have(1).error_on(:name)
  end
  
  it "should require round_count" do
  	@season.should have(1).error_on(:rounds_count)
  end
  
  it "should require question_count" do
  	@season.should have(1).error_on(:questions_count)
  end
  
  it "should create new season" do
    @season = Season.new({ :name => "First", :rounds_count => 5, :questions_count => 5})    
    lambda {
      @season.save
    }.should change(Season, :count)
  end
  
end
