class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  named_scope :my, lambda { |user| { :conditions => { :user_id => user } } }
  validates_presence_of :body

end

