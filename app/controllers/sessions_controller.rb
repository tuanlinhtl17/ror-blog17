class SessionsController < ApplicationController
  def new
    if logged_in?
      flash[:danger] = "You logged in !"
      redirect_to current_user
    else
      render "new"
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_back_or root_url
    else
      flash.now[:danger] = "Invalid email/password combination"
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "Loged out!"
    redirect_to root_url
  end
end
