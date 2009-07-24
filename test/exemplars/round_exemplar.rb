class Round < ActiveRecord::Base
  generator_for :name, :method => :next_name
  generator_for :published => false
  generator_for :start_responses_at => Time.now
  generator_for :end_responses_at => Time.now + 14.day
  generator_for :start_assess_at => Time.now + 14.day
  generator_for :end_assess_at => Time.now + 21.day

  def self.next_name
    @last_name ||= 'round'
    @last_name.succ
  end
end
