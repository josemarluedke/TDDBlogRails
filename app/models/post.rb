class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  
  validates :body, :user_id, :presence => true
  validates_numericality_of :user_id, :only_integer => true
  validates :title, :length => {:maximum => 250}, :presence => false
  validates :excerpt, :length => {:maximum => 250}, :presence => false
  validates_associated :user
  
end
