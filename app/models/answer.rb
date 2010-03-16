class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :responses
end
