class CommentsController < ApplicationController

  def create
    if logged_in?
      @comment = Comment.new(comment_params)
      if @comment.save
        flash[:success] = "Created new comment !"
        redirect_to Post.find_by(id: params[:post][:id])
      else
        flash[:danger] = "Cannot create new comment !"
        redirect_to Post.find_by(id: params[:post][:id])
      end
    else
      flash[:danger] = "You must log in first"
      redirect_to login_path
    end
  end


  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id,
                                                    post_id: params[:id])
  end
end
