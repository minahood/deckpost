class MicropostsController < ApplicationController
  before_action :logged_in_user, only:  :destroy
  before_action :correct_user, only: :destroy

  def search
    #Viewのformで取得したパラメータをモデルに渡す
    @microposts = Micropost.search(params[:search_word],params[:kind]).includes([:user,:comments]).page(params[:page]).per_page(10)
    
  end

  def bookmarks
    @microposts = current_user.bookmark_microposts.includes([:user,:comments]).page(params[:page]).per_page(10)
    
  end

  def show
    @micropost=Micropost.find(params[:id])
    @comments = @micropost.comments.includes([:user,:micropost])
  end
  
  def post_form
    respond_to do |format|
      format.html { redirect_to d_post_path }
      format.js
    end
  end
  
  def create
    if verify_recaptcha
      if logged_in?
        @micropost = current_user.microposts.build(micropost_params)  
        if @micropost.save
          flash[:success] = "Micropost created!"
          redirect_to root_url
        else
          if params[:micropost][:from]=="d_post"
            render 'static_pages/d_post'
          else
            @feed_items = current_user.feed.page(params[:page]).per_page(10)
            render 'static_pages/home'
          end
        end
      else
        
        @micropost = User.find_by(login_id: "guest").microposts.build(micropost_params)
        
        if @micropost.save
          flash[:success] = "Micropost created!"
          redirect_to microposts_search_url
        else
          render 'static_pages/d_post'
        end
      end
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url #request.referrerで前のurlに飛ぶ
  end

  private
    def micropost_params
      params.require(:micropost).permit(:content, :image, :title,:kind)
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
