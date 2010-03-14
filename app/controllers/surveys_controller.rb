class SurveysController < ApplicationController
  def index
    @surveys = Survey.all
  end
  
  def show
    @survey = Survey.find(params[:id])
  end
  
  def new
    @survey = Survey.new 
  end
  
  def create
    @survey = Survey.new(params[:survey])
    if @survey.save
      flash[:notice] = "Successfully created survey."
      redirect_to @survey
    else
      render :action => 'new'
    end
  end
  
  def edit
    @survey = Survey.find(params[:id])
  end
  
  def active
    @survey = Survey.find(params[:id])
    @all_surveys = Survey.find(:all)
    
    # set all surveys to "N"
    for all_survey in @all_surveys do
      all_survey.active = "N"
      all_survey.save
    end
    
    # set the selected to active
    @survey.active = "Y"
    
    # save and kick back to main
    if @survey.save
      flash[:notice] = "Successfully set to active."
      redirect_to surveys_url
    else
      flash[:error] = "Cannot set to active."
      redirect_to @survey
    end
  end
  
  def update
    @survey = Survey.find(params[:id])
    if @survey.update_attributes(params[:survey])
      flash[:notice] = "Successfully updated survey."
      redirect_to @survey
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
    flash[:notice] = "Successfully destroyed survey."
    redirect_to surveys_url
  end
end
