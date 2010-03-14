class AddLevelToLists < ActiveRecord::Migration
  def self.up
    add_column :lists, :level, :integer
    add_column :lists, :view, :string
  end

  def self.down
  end
end
