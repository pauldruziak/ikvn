require 'test_helper'

class SeasonTest < ActiveSupport::TestCase
  setup { Factory(:season) }
  should_have_many(:rounds)
  should_validate_presence_of(:name)
  should_validate_presence_of(:rounds_count)
  should_validate_presence_of(:questions_count)
  #should_validate_length_of(:name, :maximum => 100)
  should_validate_numericality_of(:rounds_count)
  should_validate_numericality_of(:questions_count)

  context "When created season" do
    setup { @season = Factory(:season)}
    should_change 'Season.count', :by => 1

    should "create :rounds_count rounds" do
      assert_equal Factory.attributes_for(:season)[:rounds_count], @season.rounds.count
    end

    should "create :questions_count questions in each round" do
      @season.rounds.each do |round|
        assert_equal Factory.attributes_for(:season)[:questions_count], round.questions.count
      end
    end

  end

  context "When the season" do
    setup { @season = Factory(:season)}

    context "does include the published rounds, then it" do
      should "be published" do        
        @season.rounds.first.publish
        assert @season.published?
      end
    end

    context "does not include the published rounds, then it" do
      should "not be published" do
        assert !@season.published?
      end
    end
  end

  context "Current season" do
    setup { @season = Factory(:season) }
    should "should be last published season" do
      @season.rounds.first.publish
      assert_equal @season, Season.current
    end
  end

end

