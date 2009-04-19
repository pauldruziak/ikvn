require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  should_validate_presence_of :name
  should_have_many :answers
end