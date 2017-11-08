class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @posts = current_user.feed
      @users = User.all
    else
      @posts = Post.all
      @users = User.all
    end
  end

  def hot
    @posts = Post.find(Like.hot.map(&:post_id))
    @users = User.all
  end

  def search
    content = params[:search]
    @posts = Post.search content
    @users = User.all
  end
end
