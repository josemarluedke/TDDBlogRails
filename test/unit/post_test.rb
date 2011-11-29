require 'test_helper'

class PostTest < ActiveSupport::TestCase
  fixtures :users, :posts
  
  test "Should be invalid" do
    post = create :title => nil, :excerpt => nil, :body => nil, :allow_comments => nil, :user_id => nil
    assert !post.valid?, "Post shouldn't be created"
  end
  
  test "Should required title" do
    post = create :title => nil
    assert post.errors[:title].any?, "Title should be required"
    assert !post.valid?, "Post shouldn't be created"
  end
  
  test "Should required body" do
    post = create :body => nil
    assert post.errors[:body].any?, "Body should be required"
    assert !post.valid?, "Post shouldn't be created"
  end
  
  test "Should required author" do
    post = create :user_id => nil
    assert post.errors[:user_id].any?, "Author should be required"
    assert !post.valid?, "Post shouldn't be created"
  end
  
  test "Should accept excerpt" do
    post = create :excerpt => "Testing excerpt"
    assert !post.errors[:excerpt].any?, "Excerpt should have been valid"
  end
  
  test "Should deny long excerpt" do
    post = create :excerpt => "a" * 251
    assert post.errors[:excerpt].any?, "Excerpt should have had an error"
    assert !post.valid?, "Post shouldn't be created"
  end
  
  test "Should deny non integer user" do
    post = create :user_id => "a"
    assert post.errors[:user_id].any?, "User should have had an error"
    assert !post.valid?, "Post shouldn't be created"
    
    post = create :user_id => 1.93939
    assert post.errors[:user_id].any?, "User should have had an error"
    assert !post.valid?, "Post shouldn't be created"
  end
  
  test "Check all fixtures were loaded" do
    assert_equal 2, users(:josemar).posts.size, "User should have had 2 posts"
  end
  
  private
    def create options={}
      Post.create({
        :title => 'Title',
        :excerpt=> "Excerpt",
        :body => "Body",
        :allow_comments => true,
        :user_id => 1
      }.merge(options))
    end
end