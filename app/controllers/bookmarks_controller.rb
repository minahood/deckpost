class BookmarksController < ApplicationController
  before_action :logged_in_user,only: [:create, :destroy]
  def create
    bookmark = current_user.bookmarks.build(micropost_id: params[:micropost_id])
    bookmark.save!
    @post = Micropost.find(params[:micropost_id])
    @post.bookmarkcount = @post.bookmarks.count
    @post.save!
    #お気に入り通知保留
    
    #@post.create_notification_by(current_user)
    respond_to do |format|
      format.html { redirect_to microposts_path }
      format.js
    end
  end

  def destroy
    current_user.bookmarks.find_by(micropost_id: params[:micropost_id]).destroy!
    
    @post = Micropost.find(params[:micropost_id])
    @post.bookmarkcount = @post.bookmarks.count
    @post.save!
    respond_to do |format|
      format.html { redirect_to microposts_path }
      format.js
    end
    
  end
  
  private
  def bookmark_params
    params.require(:bookmark).permit(:micropost_id)
  end
  
end
