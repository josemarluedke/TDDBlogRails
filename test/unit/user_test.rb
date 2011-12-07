require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users, :posts

  test "should be valid" do
    user = create
    assert user.valid?, "User should be created"
  end
  
  test "should be invalid" do
    user = create :name => nil, :email => nil, :password => nil
    assert !user.valid?, "User shouldn't be created"
  end
  
  test "should require name" do
    user = create :name => nil
    assert user.errors[:name].any?, "Name should be required"
    assert !user.valid?, "User shoultdn't be created"
  end
  
  test "should required email" do
    user = create :email => nil
    assert user.errors[:email].any?, "E-mail should be required"
    assert !user.valid?, "User shouldn't be created"
  end
  
  test "should deny bad email" do
    user = create :email => "bad@format"
    assert user.errors[:email].any?, "E-mail should be in a valid format"
    assert !user.valid?, "User shouldn't be created"
  end
  
  test "should required password" do
    user = create :password => nil
    assert user.errors[:password].any?, "Password should be required"
    assert !user.valid?, "User shouldn't be created"
  end
  
  test "should required longer password" do
    user = create :password => "1"
    assert user.errors[:password].any?, "Password should be 4 characters or longer"
    assert !user.valid?, "User shouldn't be created"
  end
  
  test "should deny duplicate user" do
    user = create :name => "Josemar Davi", :email => "josemardavi@gmail.com", :password => "12345"
    assert user.valid?, "User should be created"
    
    user = create :name => "Josemar Davi", :email => "josemardavi@gmail.com", :password => "12345"
    assert !user.valid?, "User shouldn't be created"
  end
  
  test "check all fixtures were loaded" do
    assert_equal 1, User.all.count, "User should have had 1 users"
  end
  
  test "Should be removed dependents posts" do
    user = User.find_by_id users(:josemar).id
    user.destroy
    assert_equal false, User.exists?(users(:josemar).id), "User should be removed"
    
    posts = Post.find_all_by_user_id users(:josemar).id
    assert_equal [], posts, "Posts should be removed"
  end

  private
    def create options = {}
      user = User.create({
        :name => "Name",
        :email => "email@example.com",
        :password => "12345"
      }.merge(options))
    end
end