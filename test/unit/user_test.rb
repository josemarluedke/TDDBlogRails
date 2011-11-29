require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "Should be invalid" do
    user = create :name => nil, :email => nil, :password => nil
    assert !user.valid?, "User shouldn't be created"
  end
  
  test "Should require name" do
    user = create :name => nil
    assert user.errors[:name].any?, "Name should be required"
    assert !user.valid?, "User shoultdn't be created"
  end
  
  test "Should required email" do
    user = create :email => nil
    assert user.errors[:email].any?, "E-mail should be required"
    assert !user.valid?, "User shouldn't be created"
  end
  
  test "Should deny bad email" do
    user = create :email => "bad@format"
    assert user.errors[:email].any?, "E-mail should be in a valid format"
    assert !user.valid?, "User shouldn't be created"
  end
  
  test "Should required password" do
    user = create :password => nil
    assert user.errors[:password].any?, "Password should be required"
    assert !user.valid?, "User shouldn't be created"
  end
  
  test "Should required longer password" do
    user = create :password => "1"
    assert user.errors[:password].any?, "Password should be 4 characters or longer"
    assert !user.valid?, "User shouldn't be created"
  end
  
  test "Should deny duplicate user" do
    user = create :name => "Josemar Davi", :email => "josemardavi@gmail.com", :password => "12345"
    assert user.valid?, "User should be created"
    
    user = create :name => "Josemar Davi", :email => "josemardavi@gmail.com", :password => "12345"
    assert !user.valid?, "User shouldn't be created"
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