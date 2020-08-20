class ApplicationController < ActionController::Base
  before_action :set_page_meta_tags
  
  include ApplicationHelper
  include SessionsHelper
  
private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください."
      redirect_to login_url
    end
  end
      
  def set_page_meta_tags
    @page_title       = t('.title')
    @page_description = t('.description')
    @page_keywords    = t('.keywords')
  end
end
