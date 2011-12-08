require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should return not logged error" do
    get :index
    assert_response :not_found
    assert_template "common/not_unlogged"
  end
  
  test "should get index" do
    get :index, {}, {:user_id => users(:josemar).id}
    assert_response :success
    assert_template "users/index"
    assert_select "table tbody tr td.name", User.all.count
  end

  test "should get show" do
    get :show, {:id => users(:josemar).id}
    assert_response :success
    assert_template "users/show"
    assert_select "h1.name", users(:josemar).name
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

  test "should delete" do
    assert_difference "User.count", -1 do
      delete :destroy, {:id => users(:josemar).id}, {:user_id => users(:josemar).id}
    end
    
    assert_redirected_to users_path
  end
    

end
