require 'test_helper'

class ListsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => List.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    List.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    List.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to list_url(assigns(:list))
  end
  
  def test_edit
    get :edit, :id => List.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    List.any_instance.stubs(:valid?).returns(false)
    put :update, :id => List.first
    assert_template 'edit'
  end
  
  def test_update_valid
    List.any_instance.stubs(:valid?).returns(true)
    put :update, :id => List.first
    assert_redirected_to list_url(assigns(:list))
  end
  
  def test_destroy
    list = List.first
    delete :destroy, :id => list
    assert_redirected_to lists_url
    assert !List.exists?(list.id)
  end
end
