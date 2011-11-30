require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  fixtures :users, :posts, :comments
  
  test "should be created" do
    comment = create :post_id => posts(:rails_rules).id
    assert comment.valid?, "Comment should be created"
  end
  
  test "should be invalid" do
    comment = create :name => nil, :email => nil, :url => nil, :active => nil, :body => nil, :post_id => 1
    assert !comment.valid?, "Comment shouldn't be created"
  end
  
  test "should required name" do
    comment = create :name => nil
    assert comment.errors[:name].any?, "Name should be required"
    assert !comment.valid?, "Comment shouldn't be created"
  end
  
  test "should required email" do
    comment = create :email => nil
    assert comment.errors[:email].any?, "E-mail should be required"
    assert !comment.valid?, "Comment shouldn't be created"
  end
  
  test "should required body" do
    comment = create :body => nil
    assert comment.errors[:body].any?, "Body should be required"
    assert !comment.valid?, "Comment shouldn't be created"
  end
  
  test "should required post" do
    comment = create :post_id => nil
    assert comment.errors[:post_id].any?, "Post should be required"
    assert !comment.valid?, "Comment shouldn't be created"
  end
  
  test "should deny bad email" do
    comment = create :email => "bad@format"
    assert comment.errors[:email].any?, "E-mail should be in a valid format"
    assert !comment.valid?, "User shouldn't be created"
  end
  
  test "cannot comment because post is cloused" do
    comment = create :post_id => posts(:ruby_rules).id
    assert !comment.valid?, "Comment shouldn't be created"
  end
  
  test "should deny long name" do
    comment = create :name => 'a' * 101
    assert comment.errors[:name].any?, "Name should have had an error, because has long text"
    assert !comment.valid?, "Comment shouldn't be created"
  end
  
  test "should deny long email" do
    comment = create :email => "#{'a' * 90}@sample.com"
    assert comment.errors[:email].any?, "E-mail should have had an error, because has long text"
    assert !comment.valid?, "Comment shouldn't be created"
  end
  
  test "Should dany bad url" do
    comment = create :url => "http://sample"
    assert comment.errors[:url].any?, "Url should be in a valid format"
    assert !comment.valid?, "Comment shouldn't be created" 
  end
  
  test "check all fixtures were loaded" do
    assert_equal 1, posts(:rails_rules).comments.size, "Post should have had 1 comment"
  end
  
  private
    def create options={}
      Comment.create({
        :name => 'Title',
        :email => 'email@sample.com',
        :url => "http://sample.com",
        :active => true,
        :body => "Body",
        :post_id => 1
      }.merge(options))
    end
end
