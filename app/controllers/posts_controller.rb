class PostsController < ApplicationController
  
  def index
    @posts = Post.all
  end
  
  def show
    (@post = Post.find_by_id params[:id]) || (return not_found)
  end
end
