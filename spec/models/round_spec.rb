require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Round do
 
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:start_responses_at)}
  it { should validate_presence_of(:end_responses_at)}
  it { should validate_presence_of(:start_assess_at)}
  it { should validate_presence_of(:end_assess_at)}
  
  it "should create round" do
    lambda do
      Factory(:round)
    end.should change(Round, :count)
  end

  it "start_responses_at should be greater than today" do
    round = Factory.build(:round, :start_responses_at => 1.day.ago)    
    round.should have(1).error_on(:start_responses_at)
  end
  
  it "end_responses_at should be greater than today" do
  	round = Factory.build(:round, :end_responses_at => 1.day.ago)
  	round.should have_at_least(1).error_on(:end_responses_at)
  end
  
  it "start_assess_at should be greater than today" do
  	round = Factory.build(:round, :start_assess_at => 1.day.ago)
  	round.should have_at_least(1).error_on(:start_assess_at)
  end
  
  it "end_assess_at should be greater than today" do
  	round = Factory.build(:round, :end_assess_at => Time.now - 1.day)
  	round.should have_at_least(1).error_on(:end_assess_at)
  end
  
  it "end_responses_at should be greater than start_responses_at" do
  	round = Factory.build(:round, :start_responses_at => Time.now + 2.day, :end_responses_at => Time.now + 1.day)
  	round.should have_at_least(1).error_on(:end_responses_at)
  end
  
  it "end_assess_at should be greater than start_assess_at" do
  	round = Factory.build(:round, :start_assess_at => Time.now + 2.day, :end_assess_at => Time.now + 1.day)
  	round.should have(1).error_on(:end_assess_at)
  end
  
  it "start_assess_at should be greater or eql than end_responses_at" do
  	round = Factory.build(:round, :end_responses_at => Time.now + 2.day, :start_assess_at => Time.now + 1.day)
  	round.should have(1).error_on(:start_assess_at)
  end
  
  describe "status" do
  	
    it "should be planned if not published" do
      round = Factory.build(:round, :published => false)
      round.status.should == :planned
    end
    
    it "should be next if published and today less than start responses" do
      round = Factory.build(:round, :published => true, :start_responses_at => 2.day.from_now)
      round.status.should == :next
    end
    
    it "should be current if published and today greater than start responses and less than end assess" do
      round = Factory.build(:round, :published => true, :start_responses_at => 1.day.ago)
    end
    
    it "should be completed if published and today greated than end responses" do
      round = Factory.build(:round, :published => true, :end_assess_at => 1.day.ago)
      round.status.should == :completed
    end
  end
  
end
