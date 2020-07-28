require 'rails_helper'

RSpec.describe "Micropost controller /", type: :request do
  include_context 'user_setup'
  include_context 'micropost_setup'
  subject{page}
  
  describe "when not logged_in" do
    it "redirect login_url if post" do
      pending
      users
      expect do 
        post microposts_path, params: {  micropost: { title: "de" ,content: "Lorem ipsum" ,kind: 1 } }
      end.to change(Micropost,:count).by(1)
      
      
    end
    
    it "redirect login_url if destroy" do
      user_post
      expect do 
        delete micropost_path(user_post)
      end.to change(Micropost,:count).by(0)
      expect(response).to redirect_to login_url
    end
  end
  
  describe "when logged_in user," do  
    it "can not delete other_users_post" do
      log_in_as(user)
      other_user_post
      expect do 
        delete micropost_path(other_user_post)
      end.to change(Micropost,:count).by(0)
      expect(response).to redirect_to root_url
    end
    
    it "can delete my post" do
      log_in_as(user)
      user_post
      expect do
        delete micropost_path(user_post)
      end.to change(Micropost,:count).by(-1)
      expect(response).to redirect_to root_url
    end
  end
  
  
end
