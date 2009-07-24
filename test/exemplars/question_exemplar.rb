class Question < ActiveRecord::Base
  generator_for :name, :method => :next_name
  generator_for :body => 'question text'

  def self.next_name
    @last_name ||= 'question'
    @last_name.succ
  end
end
