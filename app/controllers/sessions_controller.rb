class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(login_id: params[:session][:login_id].downcase)
    #if user && user.authenticate(params[:session][:password])
    if user&.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      #redirect_back_or user
      redirect_to user
    else
      flash.now[:danger] = 'ユーザーIDまたはパスワードが正しくありません。'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
