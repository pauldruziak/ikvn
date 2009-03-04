class Round < ActiveRecord::Base
  belongs_to :season
  has_many :questions
end
