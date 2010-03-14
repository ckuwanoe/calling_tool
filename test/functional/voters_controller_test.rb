require 'test_helper'

class VotersControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Voter.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Voter.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Voter.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to voter_url(assigns(:voter))
  end
  
  def test_edit
    get :edit, :id => Voter.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Voter.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Voter.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Voter.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Voter.first
    assert_redirected_to voter_url(assigns(:voter))
  end
  
  def test_destroy
    voter = Voter.first
    delete :destroy, :id => voter
    assert_redirected_to voters_url
    assert !Voter.exists?(voter.id)
  end
end
