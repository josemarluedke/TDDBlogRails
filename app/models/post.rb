class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  validates_associated :user
  
  validates :title, :body, :user, :presence => true
  validates_numericality_of :user_id, :only_integer => true
  validates :title, :length => {:maximum => 250}
  validates :excerpt, :length => {:maximum => 250}, :presence => true
end
