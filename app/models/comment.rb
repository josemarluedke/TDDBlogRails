class Comment < ActiveRecord::Base
  belongs_to :post
  validates_associated :post
  validates :name, :email, :body, :post, :presence => true
  validates :name, :email, :length => {:maximum => 100}
  validates_numericality_of :post_id, :only_integer => true
  validates :email, :email => true
  validates_url_format_of :url, :allow_nill => true
  
  validate do 
    if post
      # Post should be available for comments
      errors.add :post, "Comments are closed" unless post.allow_comments
    end
  end
end