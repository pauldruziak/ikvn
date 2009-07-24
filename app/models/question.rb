class Question < ActiveRecord::Base
  belongs_to :round
  has_many :answers
  accepts_nested_attributes_for :answers
  
  validates_presence_of :name
  validates_presence_of :body, :on => :update
  #validates_presence_of :round
  
end
