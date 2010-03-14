class CreateLists < ActiveRecord::Migration
  def self.up
    create_table :lists do |t|
      t.column :name,           :string
      t.column :canvasser_id,   :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :lists
  end
end
