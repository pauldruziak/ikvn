require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Round do
  def create_round(options = {})
  	record = Round.new({:name=>"1", 
  	                    :published => false, 
  	                    :start_responses_at => Time.now,
  					    :end_responses_at => Time.now + 14.day,
						:start_assess_at => Time.now + 14.day, 
  						:end_assess_at => Time.now + 21.day}.merge(options))
    record.save
    record
  end
  
  it "should create round" do
    lambda do
      create_round
    end.should change(Round, :count)
  end

  it "should require name" do
  	round = create_round({:name => nil})
  	round.should have(1).error_on(:name)
  end
  
  it "should require start_responses_at" do
  	round = create_round({:start_responses_at => nil})
  	round.should have(1).error_on(:start_responses_at)
  end
  
  it "should require end_responses_at" do
  	round = create_round({:end_responses_at => nil})
  	round.should have_at_least(1).error_on(:end_responses_at)
  end
  
  it "should require start_assess_at" do
  	round = create_round({:start_assess_at => nil})
  	round.should have(1).error_on(:start_assess_at)
  end
  
  it "should require end_assess_at" do
  	round = create_round({:end_assess_at => nil})
  	round.should have(1).error_on(:end_assess_at)
  end
  
  it "start_responses_at should be greater than today" do
    round = create_round({:start_responses_at => 1.day.ago})    
    round.should have(1).error_on(:start_responses_at)
  end
  
  it "end_responses_at should be greater than today" do
  	round = create_round({:end_responses_at => 1.day.ago})
  	round.should have_at_least(1).error_on(:end_responses_at)
  end
  
  it "start_assess_at should be greater than today" do
  	round = create_round({:start_assess_at => 1.day.ago})
  	round.should have_at_least(1).error_on(:start_assess_at)
  end
  
  it "end_assess_at should be greater than today" do
  	round = create_round({:end_assess_at => Time.now - 1.day})
  	round.should have_at_least(1).error_on(:end_assess_at)
  end
  
  it "end_responses_at should be greater than start_responses_at" do
  	round = create_round({:start_responses_at => Time.now + 2.day, :end_responses_at => Time.now + 1.day})
  	round.should have_at_least(1).error_on(:end_responses_at)
  end
  
  it "end_assess_at should be greater than start_assess_at" do
  	round = create_round({:start_assess_at => Time.now + 2.day, :end_assess_at => Time.now + 1.day})
  	round.should have(1).error_on(:end_assess_at)
  end
  
  it "start_assess_at should be greater or eql than end_responses_at" do
  	round = create_round({:end_responses_at => Time.now + 2.day, :start_assess_at => Time.now + 1.day})
  	round.should have(1).error_on(:start_assess_at)
  end
  
end
