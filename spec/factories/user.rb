FactoryBot.define do
  factory :user, class: User do
    sequence(:name) {"testuser"}
    sequence(:login_id) {"login"}
    password {"password"}
    password_confirmation {"password"}
    #admin {false}
    
    factory :other_user do
      sequence(:name, 'a'){|n| "test#{n}"}
      sequence(:login_id) { |n| "login#{n}"}
    end
=begin
    factory :admin_user do
      sequence(:name) {"adminuser"}
      sequence(:login_id) {"adminlogin"}
      admin {true}
    end

    
    factory :mike do
      sequence(:login_id) {"mikelogin"}
    end

    factory :riko do
      sequence(:login_id) {"rikologin"}
    end

    factory :aya do
      sequence(:login_id) {"ayalogin"}
    end
=end
  end
end
