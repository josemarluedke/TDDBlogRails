class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  
  validates :title, :body, :user_id, :presence => true
  validates_numericality_of :user_id, :only_integer => true
  validates :title, :length => {:maximum => 250}
  validates :excerpt, :length => {:maximum => 250}, :presence => true
  validates_associated :user
end
