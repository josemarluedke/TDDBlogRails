require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  def setup
    @post = posts(:rails_rules)
  end
  
  test "should be valid" do
    post = create
    assert post.valid?, "Post should be created"
  end
  
  test "should be invalid" do
    post = create :title => nil, :excerpt => nil, :body => nil, :allow_comments => nil, :user_id => nil
    assert !post.valid?, "Post shouldn't be created"
  end
  
  test "should required title" do
    post = create :title => nil
    assert post.errors[:title].any?, "Title should be required"
    assert !post.valid?, "Post shouldn't be created"
  end
  
  test "should required body" do
    post = create :body => nil
    assert post.errors[:body].any?, "Body should be required"
    assert !post.valid?, "Post shouldn't be created"
  end
  
  test "should required author" do
    post = create :user_id => nil
    assert post.errors[:user_id].any?, "Author should be required"
    assert !post.valid?, "Post shouldn't be created"
  end
  
  test "should accept excerpt" do
    post = create :excerpt => "Testing excerpt"
    assert !post.errors[:excerpt].any?, "Excerpt should have been valid"
  end
  
  test "should deny long title" do
    post = create :title => "a" * 251
    assert post.errors[:title].any?, "Title should have had an error, because has long text"
    assert !post.valid?, "Post shouldn't be created"
  end
  
  test "should deny long excerpt" do
    post = create :excerpt => "a" * 251
    assert post.errors[:excerpt].any?, "Excerpt should have had an error, because has long text"
    assert !post.valid?, "Post shouldn't be created"
  end
  
  test "should deny non integer user" do
    post = create :user_id => "a"
    assert post.errors[:user_id].any?, "User should have had an error"
    assert !post.valid?, "Post shouldn't be created"
    
    post = create :user_id => 1.93939
    assert post.errors[:user_id].any?, "User should have had an error"
    assert !post.valid?, "Post shouldn't be created"
  end
  
  test "check all fixtures were loaded" do
    assert_equal 2, users(:josemar).posts.size, "User should have had 2 posts"
  end
  
  test "should be error when user does not exist" do
    post = create :user_id => 1111000
    assert !post.valid?, "User doesn't exist, so it should be required"
  end
  
  test "Should be 1 comment" do
    post = Post.find_by_id @post.id
    assert_equal 1, post.comments.count, "Post should be 1 comment"
  end
  
  test "Should be removed dependents comments" do
    post = Post.find_by_id @post.id
    post.destroy
    assert_equal false, Post.exists?(@post.id), "Post should be removed"
    
    comments = Comment.find_all_by_post_id @post.id
    assert_equal [], comments, "Comments should be removed"
  end
  
  test "title should be updated" do
    post = Post.find_by_id @post.id
    post.title = "Bar"
    post.save
    assert_equal "Bar", Post.find_by_id(@post.id).title
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