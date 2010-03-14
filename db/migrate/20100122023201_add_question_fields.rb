class AddQuestionFields < ActiveRecord::Migration
  def self.up
    add_column :questions, :mode, :string
  end

  def self.down
  end
end
