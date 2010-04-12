class AddApprovaltoSurveyReplies < ActiveRecord::Migration
  def self.up
    add_column :survey_replies, :approval, :string
  end

  def self.down
    drop_column :survey_replies, :approval
  end
end
