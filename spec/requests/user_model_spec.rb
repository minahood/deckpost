require 'rails_helper'


RSpec.describe "model User /", type: :request do
  let(:user){User.new(name: "Example User", email: "user@example.com",
                      password: "password", password_confirmation: "password")}
  
  describe "when user has name, email and password," do
    it "user is valid" do
      expect(user).to be_valid
      user.email= ""
      expect(user).to_not be_valid
      user.email = "user@example.com"
      user.name = ""
      expect(user).to_not be_valid
    end
  end

  describe "email /" do
    context "when email is not proper," do
      it "user is invalid" do
        #適切でないアドレス
        
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
        invalid_addresses.each do |invalid_address|
          user.email = invalid_address
          expect(user).to_not be_valid
        end
        #適切なメールアドレス
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
          user.email = valid_address
          expect(user).to be_valid,"#{valid_address.inspect} should be invalid"
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
    
    context "when user.email save," do
      it "email remember in downcase" do
        mixed_email = "groFGvv@FN.com"
        user.email = mixed_email
        user.save #小文字で保存される model/user.rb参照
        expect(user.reload.email).to eq(mixed_email.downcase)
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
  
end