require 'test_helper'

class RateTest < ActiveSupport::TestCase
  should_belong_to :user
  should_belong_to :answer

  should_validate_presence_of :score
end
