require 'test_helper'

class SurveyRepliesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => SurveyReplies.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    SurveyReplies.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    SurveyReplies.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to survey_replies_url(assigns(:survey_replies))
  end
  
  def test_edit
    get :edit, :id => SurveyReplies.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    SurveyReplies.any_instance.stubs(:valid?).returns(false)
    put :update, :id => SurveyReplies.first
    assert_template 'edit'
  end
  
  def test_update_valid
    SurveyReplies.any_instance.stubs(:valid?).returns(true)
    put :update, :id => SurveyReplies.first
    assert_redirected_to survey_replies_url(assigns(:survey_replies))
  end
  
  def test_destroy
    survey_replies = SurveyReplies.first
    delete :destroy, :id => survey_replies
    assert_redirected_to survey_replies_url
    assert !SurveyReplies.exists?(survey_replies.id)
  end
end
