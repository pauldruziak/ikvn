class Round < ActiveRecord::Base
  belongs_to :season
  has_many :questions, :dependent => :destroy do
  	def not_valid
  	  self.select do |question|
  	  	!question.valid?
  	  end
  	end
  end
  named_scope :published, :conditions => { :published => true }
  
  validates_presence_of :name, :start_responses_at, :end_responses_at, :start_assess_at, :end_assess_at
  
  
  
protected
  def validate  	
  	if (!start_responses_at.nil? && start_responses_at < DateTime.now - 1.minute)
  	  errors.add(:start_responses_at, I18n.t('activerecord.errors.messages.greater_than_today'))
  	end
  	if (!end_responses_at.nil? && end_responses_at < DateTime.now)
  	  errors.add(:end_responses_at, I18n.t('activerecord.errors.messages.greater_than_today'))
  	end
  	
  	if (!start_assess_at.nil? && start_assess_at < DateTime.now)
  	  errors.add(:start_assess_at, I18n.t('activerecord.errors.messages.greater_than_today')) 
  	end
  	
	if (!end_assess_at.nil? && end_assess_at < DateTime.now)
  	  errors.add(:end_assess_at, I18n.t('activerecord.errors.messages.greater_than_today')) 
  	end 
  	
  	if (!start_responses_at.nil? && !end_responses_at.nil? && (start_responses_at > end_responses_at))
  	  errors.add(:end_responses_at, I18n.t('activerecord.errors.messages.greater_than_or_equal_to', :count => Round.human_attribute_name('start_responses_at'))) 
  	end
  	
  	if (!start_assess_at.nil? && !end_assess_at.nil? && (start_assess_at > end_assess_at))
  	  errors.add(:end_assess_at, I18n.t('activerecord.errors.messages.greater_than_or_equal_to', :count => Round.human_attribute_name('start_assess_at')))
  	end
  	
  	if (!end_responses_at.nil? && !start_assess_at.nil? && (end_responses_at > start_assess_at))
  	  errors.add(:start_assess_at, I18n.t('activerecord.errors.messages.greater_than_or_equal_to', :count => Round.human_attribute_name('end_responses_at')))
  	end
  end
	
end
