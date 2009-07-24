class Rate < ActiveRecord::Base
  belongs_to :user
  belongs_to :answer

  validates_presence_of :score
  validates_presence_of :user
end
