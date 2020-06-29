require 'rails_helper'

RSpec.describe "Micropost UI /", type: :request do
  include_context "user_setup"
  include_context "micropost_setup"
  
  
  describe "" do
    subject { page }
    it "" do
      user
      user_posts #userが3投稿 
      other_user
      other_user_posts #other_userが30投稿 
      valid_login(user)
      visit root_url
      is_expected.to have_selector 'span', text: '3 post'
      is_expected.to have_selector 'h3', text: 'Micropost Feed'
      is_expected.to have_selector 'a',text: '削除'
      
      #他のユーザーページにアクセス
      visit user_path(other_user)
      #is_expected.to have_selector 'span', text: '30 post'
      is_expected.to_not have_selector 'a',text: '削除'
      
    end
  end
end