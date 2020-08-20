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
    password:              "guestuser0000",
    password_confirmation: "guestuser0000",
)