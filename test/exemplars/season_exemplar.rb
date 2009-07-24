class Season < ActiveRecord::Base
  generator_for :name, :method => :next_name
  generator_for :rounds_count => 3
  generator_for :questions_count => 5

  def self.next_name
    @last_name ||= 'season'
    @last_name.succ
  end
end
