RSpec.describe "UsersLogin /", type: :request do
  include_context "user_setup"
  subject{page}
  
  describe "when login with invalid information" do
    it "display flash danger-messsage" do
      user
      visit root_path
      click_link "ログイン/新規登録"
      is_expected.to have_current_path login_path
      fill_in 'ログインID', with: ""
      fill_in 'パスワード', with: ""
      click_button 'ログイン'
      is_expected.to have_current_path login_path
      is_expected.to have_selector('.alert-danger')
      visit root_path
      is_expected.to_not have_selector('.alert-danger')
    end
  end
  
  describe "when login with invalid information" do
    it "success login and redirect_to user_path" do
      user
      visit root_path
      is_expected.to have_link nil, href: login_path
      click_link "ログイン/新規登録"
      is_expected.to have_current_path login_path
      fill_in 'ログインID', with: user.login_id
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      is_expected.to have_current_path user_path(user.id)
      is_expected.to_not have_link nil, href: login_path
    end
  end
  
  describe "login → logout" do
    it "motion (path and header_link)" do
      visit root_path
      is_expected.to have_link 'ログイン/新規登録', href: login_path
      is_expected.to_not have_link 'ログアウト', href: logout_path
      click_link "ログイン/新規登録"
      fill_in 'ログインID', with: user.login_id
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      
      is_expected.to have_current_path user_path(user) 
      is_expected.to_not have_link 'ログインID', href: login_path
      is_expected.to have_link 'マイページ', href: user_path(user)
      is_expected.to have_link 'ログアウト', href: logout_path
      click_link 'ログアウト'
      is_expected.to have_current_path root_path
      is_expected.to have_link 'ログイン/新規登録', href: login_path
      is_expected.to_not have_link 'ログアウト',href: logout_path
    end
  end
end