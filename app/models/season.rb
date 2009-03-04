class Season < ActiveRecord::Base	
  has_many :rounds	
  attr_accessor :rounds_count, :questions_count	
  validates_presence_of :name, :rounds_count, :questions_count
	
end
