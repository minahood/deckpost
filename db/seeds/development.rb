# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "Example User",
    login_id: "example",
    password:              "foobar",
    password_confirmation: "foobar",
    introduction: "お試しユーザーなり"
)


User.create!(name:  "mina",
    login_id: "deckpost",
    password:              ENV["MINA_KEY"],
    password_confirmation: ENV["MINA_KEY"],
    admin: true
)

User.create!(name:  "guest",
    login_id: "guest",
    password:              "guestuser",
    password_confirmation: "guestuser",
)

User.create!(name:  "絵ぼるクエンティ",
    login_id: "gggggg",
    password:              "gggggg",
    password_confirmation: "gggggg",
    admin: true
)


90.times do |n|
  name  = Faker::Name.name
  login = "example#{n+1}"
  password = "password"
  User.create!(name:  name,
               login_id: login,
               password:              password,
               password_confirmation: password,
               introduction: Faker::Lorem.sentence(word_count: 30)
               )
end

# ユーザーの一部を対象にマイクロポストを生成する
users = User.order(:created_at).take(6)
50.times do |n|
  content = Faker::Lorem.sentence(word_count: 10)
  title = Faker::Lorem.sentence(word_count: 2)
  kind = rand(0..15)
  if n < 10 then
    intention = "victory"
  elsif n < 20 then 
    intention = "winning"
  elsif n < 30 then
    intention = "battle"
  elsif n < 40 then
    intention = "fan"
  else
  end
  
  users.each { |user| user.microposts.create!(content: content,title: title,kind: kind,intention: intention) }
end

# 以下のリレーションシップを作成する
users = User.all
user  = User.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
