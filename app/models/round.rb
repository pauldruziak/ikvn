class Round < ActiveRecord::Base
  belongs_to :season
  has_many :questions, :dependent => :destroy
  named_scope :published, :conditions => { :published => true }
  
  validates_presence_of :name, :start_responses_at, :end_responses_at, :start_assess_at, :end_assess_at
  
protected
  def validate  	
  	if (!end_responses_at.nil? && end_responses_at.today?)
  	  errors.add(:end_responses_at, "must be greater than today")
  	end
  	
  	if (!start_assess_at.nil? && start_assess_at.today?)
  	  errors.add(:start_assess_at, "must be greater than today") 
  	end
  	
	if (!end_assess_at.nil? && end_assess_at.today?)
  	  errors.add(:end_assess_at, "must be greater than today") 
  	end 
  	
  	if (!start_responses_at.nil? && !end_responses_at.nil? && (start_responses_at > end_responses_at))
  	  errors.add(:end_responses_at, "must be greater or equal than start date") 
  	end
  	
  	if (!start_assess_at.nil? && !end_assess_at.nil? && (start_assess_at > end_assess_at))
  	  errors.add(:end_assess_at, "must be greater or equal than start date")
  	end
  	
  	if (!end_responses_at.nil? && !start_assess_at.nil? && (end_responses_at > start_assess_at))
  	  errors.add(:start_assess_at, "must be greater or equal than end date of filing responses")
  	end
  end
  
  def before_update
  	!published_was
  end
  	
end
