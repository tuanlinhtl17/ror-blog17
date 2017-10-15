class PostsController < ApplicationController
  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
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


  private
  def post_params
    params.require(:post).permit(:content, :title, :img_url).merge(user_id: current_user.id)
  end
end
