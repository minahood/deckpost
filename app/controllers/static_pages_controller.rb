class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user=current_user
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.includes(:user).page(params[:page]).per_page(10)
      @action = "home"
      render "shared/user_page"
    else
      @micropost_all = Micropost.all
      @recent_posts=Micropost.order(:desc).limit(5)
      render "top"
    end
  end

  def top
    if logged_in?
      @user=current_user
      @search_kind = current_user.favorite
      @micropost_all = Micropost.all
      @recent_posts=Micropost.where(kind: @search_kind).limit(5)
    else
      @micropost_all = Micropost.all
      @recent_posts=Micropost.order(:desc).limit(5)
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
      @micropost  = User.find_by(login_id: "guest").microposts.build
    end
  end
  
end
