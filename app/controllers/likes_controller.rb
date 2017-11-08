class LikesController < ApplicationController
  before_action :logged_in?

  def create
    @post = Post.find(params[:post_id])
    current_user.like @post
    respond_to do |format|
      format.html { redirect_to post }
      format.js
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @post = Post.find(@like.post_id)
    respond_to do |format|
      format.html { redirect_to post }
      format.js
    end
    current_user.unlike @post
  end
end
