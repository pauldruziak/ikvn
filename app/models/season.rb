class Season < ActiveRecord::Base	
	
  has_many :rounds, :dependent => :destroy
  
  validates_presence_of :name, :rounds_count, :questions_count
  validates_length_of :name,  :maximum => 100, :unless => Proc.new { |name| name.nil? }
  validates_numericality_of :rounds_count, :questions_count, :only_integer => true, 
                            :greater_than => 0, :less_than_or_equal_to => 30, 
                            :unless => Proc.new { |count| count.nil? }
                                  
protected

  def before_create	
  	rounds_count.times do |round_index|
  		@round = rounds.build({:name => round_index + 1,
  		                       :published => false,
  		                       :start_responses_at => Time.now + (21 * round_index).day,
  							   :end_responses_at => Time.now + (14 + (round_index * 21)).day,
							   :start_assess_at => Time.now + (14 + (round_index * 21)).day, 
  							   :end_assess_at => Time.now + (21 + (round_index * 21)).day})
  		questions_count.times do |question_index|
  			@round.questions.build({:name => question_index + 1})
  		end
  	end
  end
  
  def before_destroy
  	rounds.published.count == 0  	
  end
  
end
