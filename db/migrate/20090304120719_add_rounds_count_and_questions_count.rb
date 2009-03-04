class AddRoundsCountAndQuestionsCount < ActiveRecord::Migration
  def self.up
    add_column :seasons, :rounds_count, :integer
    add_column :seasons, :questions_count, :integer  
  end

  def self.down
  	remove_column :seasons, :rounds_count, :integer
    remove_column :seasons, :questions_count, :integer  
  end
end
