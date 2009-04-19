require 'test_helper'

class RoundTest < ActiveSupport::TestCase
  setup { Factory(:round) }
  should_validate_presence_of :name, :start_responses_at, :end_responses_at, :start_assess_at, :end_assess_at
  
  should_be_greater_than_today :start_responses_at, :end_responses_at, :start_assess_at, :end_assess_at
  
  context "Round status" do
  	
    should "be :planned if not published" do
      round = Factory.build(:round, :published => false)
      assert_equal :planned, round.status
    end
    
    should "be :next if published and today less than start responses" do
      round = Factory.build(:round, :published => true, :start_responses_at => 2.day.from_now)
      assert_equal :next, round.status
    end
    
    should "be :current if published and today greater than start responses and less than end assess" do
      round = Factory.build(:round, :published => true, :start_responses_at => 1.day.ago)
      assert_equal :current, round.status
    end

    should "be current if published and today greater than start responses and less than end assess" do
      round = Factory.build(:round, :published => true, :start_responses_at => 1.day.ago)
      assert round.current?
    end
    
    should "be :completed if published and today greated than end responses" do
      round = Factory.build(:round, :published => true, :end_assess_at => 1.day.ago)
      assert_equal :completed, round.status
    end
  end

  context "Round" do
    setup do
      @round1 = Factory(:round)
      @round2 = Factory(:round)
    end

    should "return previous round" do
      assert_equal @round1, @round2.previous
    end

    should "return next round" do
      assert_equal @round2, @round1.next
    end
  end
end
