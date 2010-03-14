module AdminHelper
  def add_answer_link(form_builder)
    link_to_function 'add an answer' do |page|
      form_builder.fields_for :answers, Answer.new, :child_index => 'NEW_RECORD' do |f|
        html = render(:partial => 'answer', :locals => { :form => f })
        page << "$('answer').insert({ bottom: '#{escape_javascript(html)}'.replace(/NEW_RECORD/g, new Date().getTime()) });"
      end
    end
  end 
  
  def add_question_link(form_builder)
    link_to_function 'add a question' do |page|
      form_builder.fields_for :questions, Question.new, :child_index => 'NEW_RECORD' do |f|
        html = render(:partial => 'question', :locals => { :form => f })
        page << "$('question').insert({ bottom: '#{escape_javascript(html)}'.replace(/NEW_RECORD/g, new Date().getTime()) });"
      end
    end
  end 
end
