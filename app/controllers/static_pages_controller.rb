class StaticPagesController < ApplicationController
  def home
    @post_arr = Post.all
    @user_arr = User.all
  end
end
