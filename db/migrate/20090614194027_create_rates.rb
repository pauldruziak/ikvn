class CreateRates < ActiveRecord::Migration
  def self.up
    create_table :rates do |t|
      t.references :user
      t.references :answer
      t.integer :score

      t.timestamps
    end
  end

  def self.down
    drop_table :rates
  end
end
