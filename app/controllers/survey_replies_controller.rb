class SurveyRepliesController < ApplicationController
  USERID = 1 
  helper_method :find_answers
  
  def index
    @list = List.find_by_user_id(USERID)
    redirect_to :action => 'new', :params => {:view => @list.view, :list => @list.id}
  end
  
  def show
    @survey_replies = SurveyReply.find(params[:id])
  end
  
  def new    
    @voters = Voter.find_by_sql(
    ["SELECT * FROM voters WHERE list_id = ? AND voters.id NOT IN 
      (SELECT voter_id FROM survey_replies WHERE user_id = ?)  LIMIT 1", params[:list], USERID])
    
    if @voters.size < 1
      redirect_to :action => 'finish'
    end
    
    @previous_survey_replies = SurveyReply.find_by_sql(
    ["SELECT v.name, v.sex, v.party, v.phone, s.* FROM survey_replies s LEFT JOIN voters v 
      on s.voter_id = v.id LEFT JOIN lists l on l.id = v.list_id WHERE s.user_id = ? AND v.list_id = ? 
      ORDER BY s.updated_at DESC LIMIT 5", USERID, params[:list]])
    @survey = Survey.find_by_active('Y')
    @questions = Question.find_all_by_survey_id(@survey.id)
    @survey_reply = SurveyReply.new
    for question in @questions do
      if question.mode == 'checkbox'
        @answers = Answer.find_all_by_question_id(question.id)
        @answers.size.times do
          @survey_reply.responses.build
        end
      else
        @survey_reply.responses.build
      end
    end
  end
  
  def create
    @survey_replies = SurveyReply.new(params[:survey_reply])
    if @survey_replies.save
      flash[:notice] = "Successfully saved results."
      redirect_to :action => 'new', :params => {:list => params[:list], :view => params[:view] }
    else
      flash[:error] = "Could not save the data, please try again."
      redirect_to :action => 'new', :params => {:list => params[:list], :view => params[:view] }
    end
  end
  
  def edit
    @list = List.find_by_user_id(USERID)
    @survey_reply = SurveyReply.find(params[:id])
    @voters = Voter.find(@survey_reply.voter_id)
    @previous_survey_replies = SurveyReply.find_by_sql(
    ["SELECT v.name, v.sex, v.party, v.phone, s.* FROM survey_replies s LEFT JOIN voters v 
      on s.voter_id = v.id LEFT JOIN list l on l.id = v.list_id WHERE s.user_id = ? AND v.list_id = ? 
      ORDER BY s.updated_at DESC LIMIT 5", USERID, @list.id])
    @survey = Survey.find_by_active('Y')
    @questions = Question.find_all_by_survey_id(@survey.id)
    render :action => 'new', :params => {:view => params[:view]}     
  end
  
  def update
    @survey_replies = SurveyReply.find(params[:survey_reply][:id])
    if @survey_replies.update_attributes(params[:survey_reply])
      flash[:notice] = "Successfully updated survey replies."
      redirect_to :action => 'edit', :params => {:id => params[:survey_reply][:id], :view => params[:view]}
    else
      flash[:error] = "Could not edit response. Please check your values and try again."
      render :action => 'edit'
    end
  end
  
  def destroy
    @survey_replies = SurveyReply.find(params[:id])
    @survey_replies.destroy
    flash[:notice] = "Successfully destroyed survey replies."
    redirect_to survey_replies_url
  end

  def manage
    @survey_replies = SurveyReply.find_by_sql(
    ["SELECT v.name, v.sex, v.party, v.phone, s.* FROM survey_replies s LEFT JOIN voters v 
      on s.voter_id = v.id LEFT JOIN lists l on l.id = v.list_id WHERE s.user_id = ? AND v.list_id = ? 
      ORDER BY s.updated_at ASC", USERID, params[:list]])
  end

  def find_answers(id)
    @answers = Answer.find_all_by_question_id(id)
  end  
end