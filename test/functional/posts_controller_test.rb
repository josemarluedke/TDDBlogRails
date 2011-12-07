require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  fixtures :posts
  
  test "should get index page" do
    get :index
    assert_response :success
    assert_template "posts/index"
  end
  
  test "should get show page" do
    get :show, {'id' => posts(:rails_rules).id}
    assert_response :success
    assert_template "posts/show"
    
    assert_select "h3.title", posts(:rails_rules).title
  end
  
  test "should return not found page" do
    #should return error in show page, because post not exist
    
    get :show, {'id' => 100}
    assert_response :not_found
    assert_template "common/not_found"
  end
  
end
