class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index,:edit, :update,:destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  def show
    @user = User.find(params[:id])
    @micropost  = @user.microposts.build
    @microposts = @user.microposts.page(params[:page]).per_page(10)
    
    @page_title = @user.name
    @page_description = @user.name + "の投稿"
    
    @action= "show"
    render "shared/user_page"
  end

  def new
    @user=User.new
  end
  
  def create
    @user = User.new(user_params)
    if verify_recaptcha
      if @user.save
        log_in @user
        remember(@user)
        flash[:success] = "ユーザー登録に成功しました。"
        redirect_to @user
      else
        render 'new'
      end
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    
  end
  
  def edit_pass
    @user = User.find(params[:id])
  end
  
  def update  
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "プロフィールを更新"
      redirect_to @user
    else
      if user_params.keys.include?("password")
        render "edit_pass"
      else
        render "edit"
      end
    end
  end
  
  def index
    @users = User.user_search(params[:word],params[:login_id],params[:favorite]).page(params[:page]).per_page(50)
    @word = params[:word]
    @login_id = params[:login_id]
    @favorite = params[:favorite]
    @current_user_follow_user = current_user.following
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  def following
    @title = "フォロー中"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page]).per_page(50)
    @micropost  = @user.microposts.build
    
    @page_title = @user.name + "のフォローリスト"
    @page_description = @user.name + "がフォロー中のユーザー"
    
    @action= "following"
    render "shared/user_page"
    
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per_page(50)
    @micropost  = @user.microposts.build
    
    @page_title = @user.name + "のフォロワーリスト"
    @page_description = @user.name + "のフォロワー一覧"
    
    @action= "followers"
    render "shared/user_page"
  end
  
  def bookmarks
    @user = User.find(params[:id])
    @micropost  = @user.microposts.build
    @microposts = @user.bookmark_microposts.includes([:user,:comments]).page(params[:page]).per_page(10)
    
    @page_title = @user.name + "のお気に入り"
    @page_title = @user.name + "のお気に入り一覧"
    
    @action= "bookmarks"
    render "shared/user_page"
  end
  
  def likes
    @user = User.find(params[:id])
    @micropost  = @user.microposts.build
    @microposts = @user.like_microposts.includes([:user,:comments]).page(params[:page]).per_page(10)
    
    @page_title = @user.name + "の高評価"
    @page_title = @user.name + "の高評価一覧"
    
    @action= "likes"
    render "shared/user_page"
  end

  private
    def user_params
      params.require(:user).permit(:name, :login_id, :password,
                                   :password_confirmation,:introduction,:favorite,:icon)
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
