class CreateResponses < ActiveRecord::Migration
  def self.up
    create_table :responses do |t|
      t.column :survey_reply_id,    :integer
      t.column :answer_id,          :integer
      t.column :date,               :date
      t.column :cycle,              :string
      t.column :user_id,            :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :responses
  end
end
