class CreateVoters < ActiveRecord::Migration
  def self.up
    create_table :voters do |t|
      t.column :van_id,     :integer
      t.column :name,       :string
      t.column :address,    :string
      t.column :phone,      :string
      t.column :email,      :string
      t.column :party,      :string
      t.column :sex,        :string
      t.column :voter_type, :string
      t.column :list_id,    :integer
      t.column :import_id,  :integer
      t.column :last_updated,   :datetime
      t.timestamps
    end
  end

  def self.down
  end
end
