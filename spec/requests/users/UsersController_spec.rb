require 'rails_helper'

RSpec.describe "Users controller /", type: :request do
  include_context 'user_setup'
  subject{page}
  
  describe "when not logged in," do
    it "redirect login_path if access edit_user_path" do
      user
      get edit_user_path(1)
      expect(response).to redirect_to login_url
      expect(response).to have_http_status(302)
      log_in_as(user)
      get edit_user_path(1)
      expect(response).to have_http_status(200)
    end
    
    it "redirect login_path if update user" do
      user
      patch user_path(user), params: { user: { name: user.name,
                                              login_id: user.login_id } }
      expect(response).to redirect_to login_url
      expect(response).to have_http_status(302)
      log_in_as(user)
      patch user_path(user), params: { user: { name: user.name,
                                              login_id: user.login_id } }
      expect(response).to redirect_to user
    end
    
    it "redirect_to login_path if destroy user" do
      user
      other_user
      expect do
        delete user_path(other_user)
      end.to change(User,:count).by(0)
      expect(response).to redirect_to login_url
    end
        
    it "redirect_to login_path if access users_path" do
      get users_url
      expect(response).to redirect_to login_url
    end
    
    
    it "friendly_forwarding" do
      pending
      #--フレンドフォワーディングのテスト----------
      visit edit_user_path(user)
      fill_in 'ユーザーID', with: user.login_id
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      is_expected.to have_current_path edit_user_path(user)
      click_link 'ログアウト'
      is_expected.to have_current_path root_path
       #再びeditに飛ばされないかチェック
      
      visit login_path
      fill_in 'ユーザーID', with: user.login_id
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      is_expected.to have_current_path user_path(user)
    end
  end

  describe "when logged in as a user," do
    it "redirect root_path if update otheruser" do
      log_in_as(user)
      patch user_path(other_user), params: { user: { name: user.name,
                                              login_id: user.login_id } }
      expect(response).to redirect_to root_url
    end
    
    it "redirect root_path if access edit_user_path(otheruser)" do
      log_in_as(user)
      get edit_user_path(other_user)
      expect(response).to redirect_to root_url
    end
  end
  
  describe "when the admin attribute is edited via the web," do
    it "not allow" do
      log_in_as(user)
      expect(user.admin?).to eq(false)
      patch user_path(user),params: {
                              user: {password:              "password",
                                    password_confirmation: "password",
                                    admin: true } 
      }
      expect(user.reload.admin?).to eq(false)
    end
  end
  
  describe "when logged in as a non-admin-user," do
    it "" do
      log_in_as(user)
      other_user
      expect do
        delete user_path(other_user)
      end.to change(User,:count).by(0)
      expect(response).to redirect_to root_url
    end
  end
  
  describe "when logged in as a admin-user," do
    it "success destroy" do
      log_in_as(admin_user)
      other_user
      expect do
        delete user_path(other_user)
      end.to change(User,:count).by(-1)
      expect(response).to redirect_to users_url
    end
  end
end
