class CommentsController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def create
    if logged_in?
        @post = Post.find(params[:comment][:post_id])
        @comment = @post.comments.create(comment_params)
        @comment.user_id = current_user.id

        if @comment.save
          respond_to do |format|
            format.html { redirect_to @post }
            format.js
          end

        else
          flash.now[:danger] = "error"
          redirect_to @post
        end
    else
      flash[:danger] = "You must log in first"
      redirect_to login_path
    end
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    if @comment.update_attributes(comment_params)
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = "Cannot edit comment"
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @comment_id = params[:id]
    Comment.find(params[:id]).destroy
    respond_to do |format|
      format.js
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :post_id).merge(user_id: current_user.id)
    end

    def correct_user
      @user = User.find_by(id: current_user.id)
      @comment = Post.find_by(id: params[:id])
      redirect_to root_url unless (@comment.user_id == current_user.id) || current_user.admin?
    end
end
