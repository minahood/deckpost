module NotificationsHelper
  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    
    #notification.actionがfollowかlikeかcommentか
    case notification.action
      when "follow" then
        tag.a(notification.visiter.name, href: user_path(@visiter), style:"font-weight: bold; color:black;",class: "stretched-link")+"があなたをフォローしました"
     
      when "bookmark" then
        tag.span(notification.visiter.name, style:"font-weight: bold;")+"が"+
          tag.a('「'+notification.micropost.title+'」', href:micropost_path(notification.micropost_id), style:"font-weight: bold; color:black;",class: "stretched-link")+
          "をお気に入りに追加 ("+tag.span(notification.micropost.bookmarks.count)+"人目)"
      
      when "like" then
        tag.span(notification.visiter.name, style:"font-weight: bold;")+"が"+
          tag.a('「'+notification.micropost.title+'」', href:micropost_path(notification.micropost_id), style:"font-weight: bold; color:black;",class: "stretched-link")+
          "にいいねしました ("+tag.span(notification.micropost.likes.count)+"人目)"
          
      when "comment" then
        @comment = notification.comment
        tag.span(@visiter.name, style:"font-weight: bold;")+"が"+
          tag.a('「'+notification.micropost.title+'」', href:micropost_path(notification.micropost_id), style:"font-weight: bold; color:black;",class: "stretched-link")+
          "にコメントしました"
    end
  end
  
  def unchecked_notifications
    @unchecked_notifications = current_user.passive_notifications.where(checked: false)
  end
end
