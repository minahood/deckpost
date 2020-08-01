class NotificationsController < ApplicationController
  before_action :logged_in_user
  
  def index
    #current_userの投稿に紐づいた通知一覧
    notifications = current_user.passive_notifications
    #すでに見たお気に入りを削除
    notifications.where(checked: true).where(action: "bookmark").destroy_all
    #@notificationの中でまだ確認していない(indexに一度も遷移していない)通知のみ
    notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    
    @notifications = notifications.includes(:visiter,:comment,:micropost).page(params[:page]).per_page(20)
  end

  def destroy_all
    #通知を全削除
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
