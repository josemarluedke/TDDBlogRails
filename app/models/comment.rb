class Comment < ActiveRecord::Base
  belongs_to :post
  validates :name, :email, :body, :post_id, :presence => true
  validate :post_closed
  validates_numericality_of :post_id, :only_integer => true
  validates :email, :email => true
  
  def post_closed
    if post
      errors.add :post, "Comments are closed" unless post.allow_comments
    end
  end
end