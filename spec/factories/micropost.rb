FactoryBot.define do
    factory :micropost, class: Micropost do
        sequence(:content){|n| "mazai #{n}回目"}
        created_at {|n| 59.minutes.ago}
        sequence(:title){|n| "deck#{n}"}
        association :user#,factory: :user
        factory :micropost_recent do
            content {"nikoniko"}
            created_at {50.minutes.ago}
            
        end
    end
    
    factory :other_micropost,class: Micropost do
        sequence(:content, 'a'){ Faker::Lorem.sentence(word_count: 5)}
        sequence(:created_at) {|n| n.hours.ago}
        sequence(:title){Faker::Lorem.sentence(word_count: 3)}
        association :user,factory: :other_user
    end

    factory :mike_micropost,class: Micropost do
        sequence(:content, 'a'){ Faker::Lorem.sentence(word_count: 5)}
        sequence(:created_at) {|n| n.hours.ago}
        sequence(:title){Faker::Lorem.sentence(word_count: 3)}
        association :user,factory: :mike
    end
    
    factory :riko_micropost,class: Micropost do
        sequence(:content, 'a'){ Faker::Lorem.sentence(word_count: 5)}
        sequence(:created_at) {|n| n.hours.ago}
        sequence(:title){Faker::Lorem.sentence(word_count: 3)}
        association :user,factory: :riko
    end

    factory :aya_micropost,class: Micropost do
        sequence(:content, 'a'){ Faker::Lorem.sentence(word_count: 5)}
        sequence(:created_at) {|n| n.hours.ago}
        sequence(:title){Faker::Lorem.sentence(word_count: 3)}
        association :user,factory: :aya
    end

end
