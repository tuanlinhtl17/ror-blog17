class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Created new post !"
      redirect_to @post
    else
      render "new"
    end
  end


  private
  def post_params
    params.require(:post).permit(:content, :user_id)
  end
end
