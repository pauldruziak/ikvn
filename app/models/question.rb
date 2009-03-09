class Question < ActiveRecord::Base
  belongs_to :round
  
  validates_presence_of :name
  validates_presence_of :body, :on => :update
  
protected
  def before_update
  	!self.round.published
  end
end
