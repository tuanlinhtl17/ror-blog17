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
    @posts = Post.hot
    @users = User.all
  end
end
