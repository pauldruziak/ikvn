class Question < ActiveRecord::Base
  belongs_to :round
  has_many :answers
  
  validates_presence_of :name
  validates_presence_of :body, :on => :update
  
end
