class NotificationsController < ApplicationController
  before_action :logged_in_user
  
  def index
    @user = current_user
    @micropost  = @user.microposts.build
    #current_userの投稿に紐づいた通知一覧
    @notifications = current_user.passive_notifications.includes(:visiter,:comment,:micropost).page(params[:page]).per_page(20)
    
  end

  def destroy_all
    #通知を全削除
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
