class AddRoles < ActiveRecord::Migration
  def self.up
  	Role.create(:name => "admin")
  	Role.create(:name => "judge")
  	Role.create(:name => "member")
  end

  def self.down
  	Role.find_by_name("admin").delete
  	Role.find_by_name("judge").delete
  	Role.find_by_name("member").delete
  end
end
