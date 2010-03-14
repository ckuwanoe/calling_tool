class Voter < ActiveRecord::Base
  belongs_to :list
  belongs_to :import
  has_many :survey_replies
  has_many :responses, :dependent => :destroy
  accepts_nested_attributes_for :responses, :reject_if => lambda { |a| a[:question_id].blank? }, :allow_destroy => true  
end