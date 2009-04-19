class Test::Unit::TestCase
    def self.should_be_greater_than_today(*attributes)
      attributes.each do |attribute|
      	context "#{attribute}" do
          should "be greater than today" do
            assert_bad_value(Round.new, attribute, 1.day.ago, I18n.t('activerecord.errors.messages.greater_than_today'))
            assert_bad_value(Round.new, attribute, 1.hour.ago, I18n.t('activerecord.errors.messages.greater_than_today'))
          end
        end
      end
    end
  end