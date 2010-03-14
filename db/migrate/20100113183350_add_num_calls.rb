class AddNumCalls < ActiveRecord::Migration
  def self.up
    add_column :lists, :num_calls, :integer
  end

  def self.down
  end
end
