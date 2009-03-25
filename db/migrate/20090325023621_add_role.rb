class AddRole < ActiveRecord::Migration
  def self.up
  	change_table(:users) do |t|
      t.boolean   :admin
      t.boolean   :judge
    end
    
    add_index :users, :admin
    add_index :users, :judge
  end

  def self.down
  	change_table(:users) do |t|
      t.remove :admin,:judge
    end
  end
end
