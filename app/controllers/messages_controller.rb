class MessagesController < ApplicationController
  def new
    @message = Message.new
    @user_receive = params[:id]
    @username = params[:username]
    respond_to do |format|
      format.js
    end
  end
  def create
      @message = current_user.active_messages.build(message_params)
      byebug
      @message.save
      ActionCable.server.broadcast "messages_#{@message.user_receive}",
                                    content: @message.content,
                                    username: current_user.name
      ActionCable.server.broadcast "messages_#{current_user.id}",
                                    content: @message.content,
                                    username: current_user.name
      # respond_to do |format|
      #   format.js
      # end
  end

  private
    def message_params
      params.require(:message).permit(:user_receive, :content).merge(user_send: current_user.id)
    end
end
