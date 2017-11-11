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
    @post = Post.new
    content = params[:search]
    if logged_in?
      @posts = []
      posts = Post.search content
      posts.each do |post|
        @posts << post if current_user.feed.include? post
      end
    else
      @posts = Post.search content
    end
    @users = User.all
  end
end
