require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:josemar)
  end
  
  test "should return unlogged error" do
    get :index
    assert_response :not_found
    assert_template "common/not_logged"
  end
  
  test "should get index" do
    get :index, {}, {:user_id => @user.id}
    assert_response :success
    assert_template "users/index"
    assert_select "table tbody tr td.name", User.count
  end

  test "should get show" do
    get :show, {:id => @user.id}
    assert_response :success
    assert_template "users/show"
    assert_select "h1.name", @user.name
  end
  
  test "should return not found" do
    get :show, {:id => 100}
    assert_response :not_found
    assert_template "common/not_found"
  end

  test "should get login" do
    get :login
    assert_response :success
    assert_template "users/login"
  end
  
  test "should be redirect to users path if correct email and password" do
    post :login, {:email => "josemarluedke@gmail.com", :password => "12345"}
    assert_redirected_to users_path
    
    get :index
    assert_response :success
    assert_template "users/index"
    assert_select "table tbody tr td.name", User.count
  end
  
  test 'should be error message if incorrect email or passwrod' do
    post :login, {:email => "josemarluedke@gmail.com", :password => "incorrect password"}
    assert_response :success
    assert_template "users/login"
    assert_select "h3.message"
  end

  test "should destroy user" do
    assert_difference "User.count", -1 do
      delete :destroy, {:id => @user.id}, {:user_id => @user.id}
    end
    assert_redirected_to users_path
  end
  
  test "should return unlogged error on destroy user" do
    delete :destroy, {:id => @user.id}
    assert_response :not_found
    assert_template "common/not_logged"
  end

end
