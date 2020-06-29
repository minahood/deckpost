RSpec.describe "UsersLogin /", type: :request do
  include_context "user_setup"
  subject{page}
  
  describe "when login with invalid information" do
    it "display flash danger-messsage" do
      user
      visit root_path
      click_link "ログイン/新規登録"
      is_expected.to have_current_path login_path
      fill_in 'ユーザーID', with: ""
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
      fill_in 'ユーザーID', with: user.login_id
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
      fill_in 'ユーザーID', with: user.login_id
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      
      is_expected.to have_current_path user_path(user) 
      is_expected.to_not have_link 'ユーザーID', href: login_path
      is_expected.to have_link 'マイページ', href: user_path(user)
      is_expected.to have_link 'ログアウト', href: logout_path
      click_link 'ログアウト'
      is_expected.to have_current_path root_path
      is_expected.to have_link 'ログイン/新規登録', href: login_path
      is_expected.to_not have_link 'ログアウト',href: logout_path
    end
  end
  
  describe "when not logged_in" do
    it "logout cause no error" do
      get root_path
      expect(response).to have_http_status(:success)
      delete logout_path
      expect(response).to redirect_to root_url
    end
  end
  
  describe "session(cookies) /" do

    it "authenticated? method check" do 
      expect(user.authenticated?(:remember, '')).to eq(false)
    end

    it "logs in with valid information followed by logout" do
      log_in_as(user)
      expect(response).to redirect_to user_path(user)
      expect(!!session[:user_id]).to eq true

      # ログアウトする
      delete logout_path
      expect(response).to redirect_to root_path
      expect(session[:user_id]).to eq nil

      # 2番目のウィンドウでログアウトする
      delete logout_path
      expect(response).to redirect_to root_path
      expect(session[:user_id]).to eq nil
    end

    it "remember cookies check" do
      log_in_as(user,remember_me:'1')
      expect(response.cookies['remember_token']).to_not eq nil
      delete logout_path
      expect(response.cookies['remember_token']).to eq nil
      log_in_as(user,remember_me:'0')
      expect(response.cookies['remember_token']).to eq nil
    end
    

    
  end
end