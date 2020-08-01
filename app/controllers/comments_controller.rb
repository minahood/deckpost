class CommentsController < ApplicationController
  before_action :logged_in_user,only: [:create, :destroy]
  def create
    @comment = current_user.comments.build(comment_params)
    @comment_micropost = @comment.micropost
    if @comment.save
      @comment_micropost.create_notification_comment!(current_user,@comment.id)
      flash[:success] = "コメントを送信しました。"
      redirect_to micropost_path(@comment.micropost)
    else
      flash[:danger] = "コメントの送信に失敗しました。"
      redirect_to micropost_path(@comment.micropost)
    end
  end
  
  def destroy
    comment = Comment.find(params[:id])
    return redirect_to root_url if comment.nil?
    micropost = comment.micropost
    comment.destroy!
    
    flash[:success] = "コメントを削除しました。"
    redirect_to micropost_path(micropost)
  end
  
  private
  def comment_params
    params.permit(:content,:micropost_id)
    
  end
  
end
