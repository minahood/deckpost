class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end
  
  def about
  end
  
  def news
  end
  
  def contact
  end
  
  def d_post
    if logged_in?
      @micropost  = current_user.microposts.build
    else
      @micropost  = User.find(2).microposts.build
    end
  end
  
end
