class PostsController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
    @comment_arr = Comment.where(post_id: @post.id)
    @comment = Comment.new
  end

  def new
    if logged_in?
      @post = Post.new
    else
      flash[:danger] = "You must log in first"
      redirect_to login_path
    end
  end

  def create
    if logged_in?
      @post = Post.new(post_params)
      if @post.save
        flash[:success] = "Created new post !"
        redirect_to @post
      else
        render "new"
      end
    else
      flash[:danger] = "You must log in first"
      redirect_to login_path
    end
  end

  def edit
    if logged_in?
      @post = Post.find_by(id: params[:id])
    else
      flash[:danger] = "You must log in first"
      redirect_to login_path
    end
  end

  def update
    if logged_in?
      @post = Post.find_by(id: params[:id])
      if @post.update_attributes(post_params)
        flash[:success] = "Post updated"
        redirect_to @post
      else
        render "edit"
      end
    else
      flash[:danger] = "You must log in first"
      redirect_to login_path
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = "Post deleted"
    redirect_to root_url
  end

  private
    def post_params
      params.require(:post).permit(:content, :title, :img_url, :all_tags).merge(user_id: current_user.id)
    end

    def correct_user
      @user = User.find_by(id: current_user.id)
      @post = Post.find_by(id: params[:id])
      redirect_to root_url unless (@post.user_id == current_user.id) || current_user.admin?
    end
end
