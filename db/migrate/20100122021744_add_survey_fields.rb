class AddSurveyFields < ActiveRecord::Migration
  def self.up
    add_column :surveys, :open_script, :text
    add_column :surveys, :close_script, :text
    add_column :surveys, :active, :string
  end

  def self.down
  end
end
