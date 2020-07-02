require 'rails_helper'


RSpec.describe "model User /", type: :request do
  let(:user){User.new(name: "Example User", login_id: "login",
                      password: "password", password_confirmation: "password")}
  
  describe "when user has name, login_id and password," do
    it "user is valid" do
      expect(user).to be_valid
      user.login_id= ""
      expect(user).to_not be_valid
      user.login_id = "wwwww"
      user.name = ""
      expect(user).to_not be_valid
    end
  end

  describe "login_id /" do
    context "when login_id is not proper," do
      it "user is invalid" do
        #適切でないアドレス
        
        invalid_ids = %w[こふぇこ koｎｎ nnn 15character1over n-nn]
        invalid_ids.each do |invalid_id|
          user.login_id = invalid_id
          expect(user).to_not be_valid
        end
        #適切なメールアドレス
        valid_ids = %w[use11 3473209470 15characterjust]
        valid_ids.each do |valid_id|
          user.login_id = valid_id
          expect(user).to be_valid,"#{valid_id.inspect} should be invalid"
        end
      end
    end
    
    context "when email is not unique," do
      it "user is invalid" do
        duplicate_user = user.dup
        user.save
        expect(duplicate_user).to_not be_valid
      end
    end
    
    context "when user.login_id save," do
      it "login_id remember in downcase" do
        mixed_login_id = "groFGvFcom"
        user.login_id = mixed_login_id
        user.save #小文字で保存される model/user.rb参照
        expect(user.reload.login_id).to eq(mixed_login_id.downcase)
      end
    end
  end
  
  describe "password /" do
    context "when pass has no minimum length," do
      it "user is invalid" do
        
        user.password = user.password_confirmation = "a" * 3
        expect(user).to_not be_valid
        user.password = user.password_confirmation = "a" * 4
        expect(user).to be_valid
      end
    end
    
    context "when pass is blank," do
      it "user is invalid" do
        user.password = user.password_confirmation = "" * 4
        expect(user).to_not be_valid
      end
    end
  end
  
  describe "when user is deleted," do
    it "users_microposts is destroyed" do
      user.save
      user.microposts.create(content: "kokoiti")
      expect do
        user.destroy
      end.to change(User, :count).by(-1)
    end
  end
  
  include_context "user_setup"
  describe "method check /" do
    it "follow and unfollow" do
      
      
      expect(user.following?(other_user)).to eq(false)
      user.follow(other_user)
      expect(user.following?(other_user)).to eq(true)
      expect(other_user.followers.include?(user)).to eq(true)
      user.unfollow(other_user)
      expect(user.following?(other_user)).to eq(false)
    end
  end
end