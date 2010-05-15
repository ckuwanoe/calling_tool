class AddToVoterInfo < ActiveRecord::Migration
  def self.up
    add_column :voters, :city, :string
    add_column :voters, :age, :integer
  end

  def self.down
    drop_column :voters, :city
    drop_column :voters, :age
  end
end
