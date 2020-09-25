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
     
    case @search_kind 
    when "4" then
      kind = "遊戯王デュエルリンクス"
      @page_description = "#{kind}" + "のデッキレシピを検索 - TCGのデッキレシピを検索・投稿・共有サイト「デッキポスト」"
      @page_title = "#{kind}" + "のデッキレシピを検索"
      
    when "5" then
      kind = "遊戯王ラッシュデュエル"
      @page_description = "#{kind}" + "のデッキレシピを検索 - TCGのデッキレシピを検索・投稿・共有サイト「デッキポスト」"
      @page_title = "#{kind}" + "のデッキレシピを検索"  
    when "6" then 
      kind = "ポケモンカード(ポケカ)"
      @page_description = "#{kind}" + "のデッキレシピを検索 - TCGのデッキレシピを検索・投稿・共有サイト「デッキポスト」"
      @page_title = "#{kind}" + "のデッキレシピを検索"
    when "8" then 
      kind = "ヴァイスシュヴァルツ(ヴァイス)"
      @page_description = "#{kind}" + "のデッキレシピを検索 - TCGのデッキレシピを検索・投稿・共有サイト「デッキポスト」"
      @page_title = "#{kind}" + "のデッキレシピを検索"
    when "10" then
      kind = "バトルスピリッツ(バトスピ)"
      @page_description = "#{kind}" + "のデッキレシピを検索 - TCGのデッキレシピを検索・投稿・共有サイト「デッキポスト」"
      @page_title = "#{kind}" + "のデッキレシピを検索"
    when "11" then 
      kind = "デジモンカード(デジカ)"
      @page_description = "#{kind}" + "のデッキレシピを検索 - TCGのデッキレシピを検索・投稿・共有サイト「デッキポスト」"
      @page_title = "#{kind}" + "のデッキレシピを検索"
    when "12" then 
      kind = "ウィクロス(WIXOSS)"
      @page_description = "#{kind}" + "のデッキレシピを検索 - TCGのデッキレシピを検索・投稿・共有サイト「デッキポスト」"
      @page_title = "#{kind}" + "のデッキレシピを検索"
    when "13" then 
      kind = "Z/X(ゼクス)"
      @page_description = "#{kind}" + "のデッキレシピを検索 - TCGのデッキレシピを検索・投稿・共有サイト「デッキポスト」"
      @page_title = "#{kind}" + "のデッキレシピを検索"
    else
      if !@search_kind.blank? 
        kind = deck_kind.key(@search_kind.to_i) #こうしないとなぜかkey()メソッド使えない
        @page_description = "#{kind}" + "のデッキレシピを検索 - TCGのデッキレシピを検索・投稿・共有サイト「デッキポスト」"
        @page_title = "#{kind}" + "のデッキレシピを検索"
      else
        kind = "デッキレシピ"
        @page_description = "デッキ検索-TCGデッキレシピを検索・投稿・共有サイト「デッキポスト」"
        @page_title = "デッキを検索"
      end
    end
    
    @page_keywords = "#{kind}"
  end

  def show
    @micropost=Micropost.find_by(id: params[:id])  #find使うとない時にエラーなるからfind_by
    return redirect_to root_url if @micropost.nil? #showで削除したとき対策
    
    @comments = @micropost.comments.includes([:user,:micropost])
    
    @page_title = @micropost.title 
    @page_description = "投稿者:" + @micropost.user.name + " | 解説:" + @micropost.content if !@micropost.content.blank?
    @page_image = @micropost.image.url
    
    @page_keywords = "#{@micropost.title}"
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
      
      @micropost = User.find_by(login_id: "guest").microposts.build(micropost_params)
      if @micropost.save
        flash[:success] = "投稿に成功しました!"
        redirect_to search_microposts_url
      else
        render 'static_pages/d_post'
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
      params.require(:micropost).permit(:content, :image,:image2, :title,:kind,:intention)
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
