class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :rates
  accepts_nested_attributes_for :rates
  named_scope :my, lambda { |user| { :conditions => { :user_id => user } } }
  validates_presence_of :body

  def average
    sum = 0
    self.rates.each { |rate| sum += rate.score }
    sum.to_f / self.rates.count
  end
end

