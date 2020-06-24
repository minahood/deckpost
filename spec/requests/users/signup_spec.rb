require 'rails_helper'

RSpec.describe "Users signup/", type: :request do
  subject { page }
  describe "signup関連" do
    let(:params_NG){{ name: "",login_id: "tes",password:"foo",password_confirmation: "bar" }}
    let(:params_OK){{ name: "jack",login_id: "testuser",password:"foobar",password_confirmation: "foobar" }}
    before do
      visit signup_path
    end
    
    it "name無しで登録NG" do
      expect do
        post users_path, params: { user: params_NG }
      end.to change(User, :count).by(0)
    end
    
    it 'signup登録OK' do
      expect do
        post users_path, params: { user: params_OK} #FactoryBot.attribute_for(:user)
      end.to change(User, :count).by(1)
    end
  end

  context 'when enter an valid values' do
    before do
      visit signup_path
      fill_in '名前', with: 'testuser'
      fill_in 'ユーザーID', with: 'login'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード確認', with: 'password'
      click_button 'アカウント登録'
    end
    
    it 'gets an flash message' do
      expect(page).to have_selector('.alert-success')
      expect(page).to have_current_path user_path(1)
    end
  end

  
  context 'when enter an invalid values' do
    before do
      visit signup_path
      fill_in '名前', with: ''
      fill_in 'ユーザーID', with: ''
      fill_in 'パスワード', with: ''
      fill_in 'パスワード確認', with: ''
      click_button 'アカウント登録'
    end
    
    it 'gets an errors' do
      is_expected.to have_selector('#error_explanation')
      is_expected.to have_selector('.alert-danger')
    end
  end
end
