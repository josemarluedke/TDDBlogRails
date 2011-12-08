require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  
  test "should get index page" do
    get :index
    assert_response :success
    assert_template "posts/index"
    assert_select "article h3.title a", Post.all.count
  end
  
  test "should get show page" do
    get :show, {'id' => posts(:rails_rules).id}
    assert_response :success
    assert_template "posts/show"
    assert_select "article h1.title", {:count => 1, :text => posts(:rails_rules).title}
  end
  
  test "should return not found page" do
    #should return error in show page, because post not exist
    get :show, {'id' => 100}
    assert_response :not_found
    assert_template "common/not_found"
  end
  
end
