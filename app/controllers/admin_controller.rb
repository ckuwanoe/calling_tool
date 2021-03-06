class AdminController < ApplicationController
  require 'spreadsheet'

  def importList    
  end
    
  def upload_file
    path = self.create_file(params[:list][:upload])    
    if path == nil
      flash[:error] = "Could not upload file."
      return false
    end    
    book = Spreadsheet.open path  
    sheet1 = book.worksheet 0
    i = 0    
    sheet1.each 1 do |row|
       @voter = Voter.new
       @voter.van_id = row[0]
       @voter.name = row[2] + ' ' + row[1]
       @voter.address = row[5]
       @voter.city = row[6]
       @voter.phone = row[10]
       @voter.email = row[11]
       @voter.party = row[12]
       @voter.sex = row[13]
       @voter.age = row[14]
       @voter.level = params[:list][:level]
       @voter.import_date = Time.now.strftime("%Y-%m-%d")
       @voter.voter_type = params[:list][:voter_type]
       @voter.save
       i = i+1
    end    
    return i
  end  
  
  def create_file(upload)
    name =  upload.original_filename 
    directory = "public/spreadsheets"
    path = File.join(directory, name)
    File.open(path, "wb") { |f| f.write(upload.read) }    
    return path
  end  
  
  def add_question_form
    render :partial => "add_question"
  end
  
  def add_answer_form
    render :partial => "add_answer"
  end
 
  def add_question
    @question = Question.new
  end
  
  def add_survey
    @survey = Survey.new
  end
  
  def view_queue
    sql = "SELECT v.name as voter_name, q.content as question_text, a.content as answer_text FROM survey_replies as s LEFT JOIN voters v on 
    s.voter_id = v.id LEFT JOIN responses r on s.id = r.survey_reply_id LEFT JOIN 
    answers a on a.id = r.answer_id LEFT JOIN questions q on q.id = a.question_id WHERE s.approval = 'W' ORDER BY s.created_at ASC"
    @survey_replies = SurveyReply.find_by_sql(sql)
  end
  
  def approve_responses
     
  end
end
