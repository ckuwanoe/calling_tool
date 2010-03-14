class ResponsesController < ApplicationController
  USERID = 1
 
  helper_method :find_answers
  
  def index
    @responses = Response.new
    @list = List.find_by_user_id(USERID)
    @voters = Voter.find_all_by_list_id(@list.id)
    @survey = Survey.find_by_active('Y')
    @questions = Question.find_all_by_survey_id(@survey.id)
  end
  
  def show
    @response = Response.find(params[:id])
  end
  
  def new
    @response = Response.new
  end
  
  def create
    @response = Response.new(params[:response])
    if @response.save
      flash[:notice] = "Successfully created response."
      redirect_to :controller => 'responses', :params => {:i => params[:i]}
    else
      render :action => 'new'
    end
  end
  
  def edit
    @response = Response.find(params[:id])
  end
  
  def update
    @response = Response.find(params[:id])
    if @response.update_attributes(params[:response])
      flash[:notice] = "Successfully updated response."
      redirect_to @response
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @response = Response.find(params[:id])
    @response.destroy
    flash[:notice] = "Successfully destroyed response."
    redirect_to responses_url
  end
  
  def find_answers(id)
    @answers = Answer.find_all_by_question_id(id)
  end
end
