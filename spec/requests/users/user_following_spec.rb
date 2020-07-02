require 'rails_helper'

RSpec.describe "User_follow", type: :request do
    include_context "user_setup"
    before do
        user
        users
        users.each do |u|
            u.follow(user)
            user.follow(u)
        end
    end

    describe "when not logged_in /" do
      it "redirect login_path if access following_list and following page check" do
        visit following_user_path(user)
        expect(page).to have_current_path login_path
        valid_login(user)
        visit following_user_path(user)
        user.following.each do |u|
          expect(page).to have_link u.name ,href: user_path(u)
        end
      end
    end
    
    describe "when not logged_in /" do
      it "redirect login_path if aceess follower_list and followers page check" do
        visit followers_user_path(user)
        expect(page).to have_current_path login_path
        valid_login(user)
        visit followers_user_path(user)
        user.followers.each do |u|
          expect(page).to have_link u.name ,href: user_path(u)
        end
      end
    end
    
end
