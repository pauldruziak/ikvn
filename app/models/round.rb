class Round < ActiveRecord::Base
  belongs_to :season
  has_many :questions
  named_scope :published, :conditions => { :published => true }
end
