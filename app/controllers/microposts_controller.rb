class MicropostsController < ApplicationController
  before_action :logged_in_user, only:  :destroy
  before_action :correct_user, only: :destroy

  def search
    #Viewのformで取得したパラメータをモデルに渡す
    #@microposts = Micropost.post_search(params[:search_word],params[:kind],params[:intention]).includes([:user,:comments,:bookmarks,:likes]).page(params[:page]).per_page(10)
    @microposts = Micropost.post_search(params[:word],params[:kind],params[:intention]).post_sort(params[:sort]).includes([:user,:comments,:bookmarks,:likes]).page(params[:page]).per_page(10)
    @search_word =params[:word]
    @search_kind = params[:kind]
    @search_intention = params[:intention] 
    @search_sort = params[:sort] 
    
    if @search_kind
      kind = deck_kind.key(@search_kind.to_i) #こうしないとなぜかkey()メソッド使えない
      
      @page_description = "#{kind}" + "のデッキを検索。TCGのデッキを検索・投稿・共有するSNS「デッキポスト」"
      @page_title = "#{kind}" + "のデッキを検索"
    else
      @page_description = "デッキ検索-デッキポスト"
      @page_title = "デッキを検索"
    end
      
  end

  def show
    @micropost=Micropost.find(params[:id])
    @comments = @micropost.comments.includes([:user,:micropost])
    
    @page_title = @micropost.title
  end
  
  def post_form
    respond_to do |format|
      format.html { redirect_to d_post_path }
      format.js
    end
  end
  
  def create
    
    if logged_in?
      @micropost = current_user.microposts.build(micropost_params)  
      if @micropost.save
        flash[:success] = "投稿に成功しました!"
        redirect_to root_url
      else
        if params[:micropost][:from]=="d_post"
          render 'static_pages/d_post'
        else
          @feed_items = current_user.feed.page(params[:page]).per_page(10)
          @user=current_user
          
          render 'static_pages/home'
        end
      end
    else
      if verify_recaptcha
        @micropost = User.find_by(login_id: "guest").microposts.build(micropost_params)
        if @micropost.save
          flash[:success] = "投稿に成功しました!"
          redirect_to microposts_search_url
        else
          render 'static_pages/d_post'
        end
      else
        render 'static_pages/home'
      end
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to request.referrer || root_url #request.referrerで前のurlに飛ぶ
  end

  private
    def micropost_params
      params.require(:micropost).permit(:content, :image, :title,:kind,:intention)
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
