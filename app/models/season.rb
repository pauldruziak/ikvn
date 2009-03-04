class Season < ActiveRecord::Base	
	
  has_many :rounds	
  
  validates_presence_of :name, :rounds_count, :questions_count
  validates_length_of :name, :maximum => 100, :unless => Proc.new { |name| name.nil? }
  validates_numericality_of :rounds_count, :questions_count, :only_integer => true, 
                            :greater_than => 0, :less_than_or_equal_to => 30, 
                            :unless => Proc.new { |count| count.nil? }
  
  before_create :create_tours_and_questions 
  before_destroy :published_round?
  
protected

  def create_tours_and_questions	
  	self.rounds_count.times do |round_index|
  		@round = self.rounds.build({:name => round_index + 1})
  		self.questions_count.times do |question_index|
  			@round.questions.build({:name => question_index + 1})
  		end
  	end
  end
  
  def published_round?
  	self.rounds.published.count == 0  	
  end
  
end
