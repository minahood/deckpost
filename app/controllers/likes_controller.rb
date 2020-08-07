class LikesController < ApplicationController
  before_action :logged_in_user,only: [:create, :destroy]
  def create
    like = current_user.likes.build(micropost_id: params[:micropost_id])
    like.save!
    @post = Micropost.find(params[:micropost_id])
    
    respond_to do |format|
      format.html { redirect_to microposts_path }
      format.js
    end
  end

  def destroy
    current_user.likes.find_by(micropost_id: params[:micropost_id]).destroy!
    
    @post = Micropost.find(params[:micropost_id])
    respond_to do |format|
      format.html { redirect_to microposts_path }
      format.js
    end
    
  end
  
end
