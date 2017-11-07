class BookmarksController < ApplicationController
  before_action :logged_in?

  def create
    @post = Post.find(params[:post_id])
    current_user.bookmark @post
    respond_to do |format|
      format.html { redirect_to post }
      format.js
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @post = Post.find(@bookmark.post_id)
    respond_to do |format|
      format.html { redirect_to post }
      format.js
    end
    current_user.unbookmark @post
  end
end
