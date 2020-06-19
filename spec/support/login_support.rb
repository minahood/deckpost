module Test_Login_Helpers
  def is_logged_in?
      !session[:user_id].nil?
  end

  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path, params: { session: { login_id: user.login_id,
                                          password: password,
                                          remember_me: remember_me } }
  end

  def valid_login(user)
    visit root_path
    click_link "ログイン/新規登録"
    fill_in 'login_id', with: user.email
    fill_in 'Password', with: user.password
    click_button '新規登録'
  end


end
