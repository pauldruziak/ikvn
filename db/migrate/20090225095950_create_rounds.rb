class CreateRounds < ActiveRecord::Migration
  def self.up
    create_table :rounds do |t|
      t.references :season
      t.string :name
      t.boolean :published
      t.datetime :start_responses_at
      t.datetime :end_responses_at
      t.datetime :start_assess_at
      t.datetime :end_assess_at

      t.timestamps
    end
  end

  def self.down
    drop_table :rounds
  end
end
