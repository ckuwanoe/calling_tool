class QuestionsController < ApplicationController
  def index
  end
  
  def create
    @question = Question.new(params[:question])
    success = @question && @question.save
    if success
      flash[:notice] = "Question added successfully."
      redirect_to(:controller => 'admin', :action => 'index')
    else
      flash[:error] = "Question could not be added, please try again."
      redirect_to(:controller => 'admin', :action => 'index')
    end
  end
end