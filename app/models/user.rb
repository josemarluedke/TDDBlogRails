class User < ActiveRecord::Base
  validates :name, :email, :password, :presence => true
  validates :password, :length => {:minimum => 4}
  validates :email, :uniqueness => true
  validates :email, :email => true
  
  has_many :posts, :dependent => :destroy
end
