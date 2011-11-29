require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  fixtures :users, :posts, :comments
  
  test "Should be created" do
    comment = create :post_id => posts(:rails_rules).id
    assert comment.valid?, "Comment should be created"
  end
  
  test "Should be invalid" do
    comment = create :name => nil, :email => nil, :url => nil, :active => nil, :body => nil, :post_id => 1
    assert !comment.valid?, "Comment shouldn't be created"
  end
  
  test "Should required name" do
    comment = create :name => nil
    assert comment.errors[:name].any?, "Name should be required"
    assert !comment.valid?, "Comment shouldn't be created"
  end
  
  test "Should required email" do
    comment = create :email => nil
    assert comment.errors[:email].any?, "E-mail should be required"
    assert !comment.valid?, "Comment shouldn't be created"
  end
  
  test "Should required body" do
    comment = create :body => nil
    assert comment.errors[:body].any?, "Body should be required"
    assert !comment.valid?, "Comment shouldn't be created"
  end
  
  test "Should required post" do
    comment = create :post_id => nil
    assert comment.errors[:post_id].any?, "Post should be required"
    assert !comment.valid?, "Comment shouldn't be created"
  end
  
  test "Should deny bad email" do
    comment = create :email => "bad@format"
    assert comment.errors[:email].any?, "E-mail should be in a valid format"
    assert !comment.valid?, "User shouldn't be created"
  end
  
  test "Cannot comment because post is cloused" do
    comment = create :post_id => posts(:ruby_rules).id
    assert !comment.valid?, "Comment shouldn't be created"
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
