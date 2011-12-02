class PostsController < ApplicationController
  
  def index
    
  end
  
  def show
    (@post = Post.find_by_id params[:id]) || not_found
  end
  
  def not_found
    render "common/not_found", :status => 404
  end
end
