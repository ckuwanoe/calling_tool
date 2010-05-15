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
    @list = List.new(params[:list])
    @list.user_id = USERID
    success = @list && @list.save   
    #if success.empty?
    #  flash[:error] = "There was a problem creating the list.  Please contact support."
    #  return false
    #end
    @voters = Voter.find(:all, :limit => @list.num_calls, :conditions => ["list_id is NULL AND level = ?", @list.level])
    for voter in @voters
      voter.list_id = @list.id
      voter.last_updated = Time.now.strftime("%Y-%m-%d %H:%M:%S")
      voter.save
    end
    
    redirect_to :controller => 'survey_replies'
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
    @check = List.find(:all, :conditions => ["user_id = ?", USERID])
    if @check.empty?
      return false
    else
      responded = List.find_by_sql(["SELECT count(s.id) as num FROM voters AS v LEFT JOIN 
      survey_replies AS s ON v.id = s.voter_id LEFT JOIN lists AS l ON l.id = v.list_id WHERE l.id = ?", @check[0].id])
      count = Voter.find_by_sql(["SELECT count(id) as num FROM voters WHERE list_id = ?", @check[0].id])
      if responded[0].num == count[0].num
        return false
      else
        return true
      end
    end   
  end
end
