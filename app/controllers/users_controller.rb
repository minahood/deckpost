class UsersController < ApplicationController
  def show
    @user=User.find(params[:id])
  end

  def new
    @user=User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザー登録に成功しました。"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :login_id, :password,
                                   :password_confirmation,:introduction)
    end
end
