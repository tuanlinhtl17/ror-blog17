class CommentsController < ApplicationController

  def create
    if logged_in?
        @post = Post.find(params[:comment][:post_id])
        @comment = @post.comments.create(comment_params)
        @comment.user_id = current_user.id

        if @comment.save
          respond_to do |format|
            format.html { redirect_to @post }

            format.json do
              render json: {
                content: @comment.content,
                user_name: current_user.name,
                avatar: current_user.avatar_url
              }.to_json
            end
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


  private
  def comment_params
    params.require(:comment).permit(:content, :post_id).merge(user_id: current_user.id)
  end
end
