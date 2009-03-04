require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Round do
  before(:each) do
    @valid_attributes = {
      #:season => ,
      :name => "value for name",
      :published => true,
      :start_responses_at => Time.now,
      :end_responses_at => Time.now,
      :start_assess_at => Time.now,
      :end_assess_at => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    #Round.create!(@valid_attributes)
  end
end
