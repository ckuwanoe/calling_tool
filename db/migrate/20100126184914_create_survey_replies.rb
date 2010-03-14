class CreateSurveyReplies < ActiveRecord::Migration
  def self.up
    create_table :survey_replies do |t|
      t.column  :voter_id,      :integer
      t.column  :datetime,      :datetime
      t.timestamps
    end
  end

  def self.down
    drop_table :survey_replies
  end
end
