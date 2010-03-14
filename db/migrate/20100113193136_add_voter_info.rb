class AddVoterInfo < ActiveRecord::Migration
  def self.up
    add_column :voters, :import_date, :datetime
    add_column :voters, :level, :integer
  end

  def self.down
  end
end
