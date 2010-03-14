class SurveyReply < ActiveRecord::Base
  belongs_to :voter
  has_many :responses
  accepts_nested_attributes_for :responses, :reject_if => lambda { |a| a[:answer_id].blank? }, :allow_destroy => true  
end
