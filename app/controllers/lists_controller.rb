class ListsController < ApplicationController
  require 'rvan'  
  require 'rubygems'
  require 'builder'
  require 'spreadsheet'
  helper_method :check_list

  USERID = 1
    
  def index
    @list = List.new
  end
  
  def show
    @list = List.find(params[:id])
  end
  
  def new
    @list = List.new
  end
  
  def create    
    # create the dataset
    @list = List.new(params[:list])
    @list.user_id = USERID
  
    # check to see if the save is successful
    success = @list && @list.save   
    
    #if success.empty?
    #  flash[:error] = "There was a problem creating the list.  Please contact support."
    #  return false
    #end
    
    # pull list of voters
    @voters = Voter.find(:all, :limit => @list.num_calls, :conditions => ["list_id is NULL AND level = ?", @list.level])
    
    # update voters so we know they're checked out
    for voter in @voters
      voter.list_id = @list.id
      voter.last_updated = Time.now.strftime("%Y-%m-%d %H:%M:%S")
      voter.save
    end
    
    redirect_to survey_replies_url
  end
  
  def edit
    @list = List.find(params[:id])
  end
  
  def update
    @list = List.find(params[:id])
    if @list.update_attributes(params[:list])
      flash[:notice] = "Successfully updated list."
      redirect_to @list
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @list = List.find(params[:id])
    @list.destroy
    flash[:notice] = "Successfully destroyed list."
    redirect_to lists_url
  end 
  
  def check_list
    # make sure the user does not already have a list created
    @check = List.find(:all, :conditions => ["user_id = ?", USERID])
    
    # if the user does have a list, output error and exit
    if @check.empty?
      return false
    end
    return true   
  end
end
