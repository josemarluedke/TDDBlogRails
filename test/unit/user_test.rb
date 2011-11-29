require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "should be invalid" do
    user = User.create(:name => nil, :email => nil, :password => nil)
    assert !user.valid?, "User shouldn't be created"
  end
  
  test "should require name" do
    user = User.create :name => nil
    assert user.errors[:name].any?, "Name should be required"
    assert !user.valid?, "User shoultdn't be created"
  end
  
  test "should required email" do
    user = User.create :email => nil
    assert user.errors[:email].any?, "E-mail should be required"
    assert !user.valid?, "User shouldn't be created"
  end
  
  test "should deny bad email" do
    user = User.create :email => "bad@format"
    assert user.errors[:email].any?, "E-mail should be in a valid format"
    assert !user.valid?, "User shouldn't be created"
  end
  
  test "should required password" do
    user = User.create :password => nil
    assert user.errors[:password].any?, "Password should be required"
    assert !user.valid?, "User shouldn't be created"
  end
  
  test "should required longer password" do
    user = User.create :password => "1"
    assert user.errors[:password].any?, "Password should be 4 characters or longer"
    assert !user.valid?, "User shouldn't be created"
  end
  
  test "should deny duplicate user" do
    user = User.create :name => "Josemar Davi", :email => "josemardavi@gmail.com", :password => "12345"
    assert user.valid?, "User should be created"
    
    user = User.create :name => "Josemar Davi", :email => "josemardavi@gmail.com", :password => "12345"
    assert !user.valid?, "User shouldn't be created"
  end
  
  
  
end
