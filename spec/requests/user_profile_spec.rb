require 'rails_helper'

RSpec.describe "User_profile", type: :request do
  
  include_context "user_setup"
  include_context "micropost_setup"

  subject{page}

  it "profile display" do
    user_posts  
    visit user_path(user)
    is_expected.to have_title full_title(user.name)

    expect(user.microposts.count).to eq user_posts.count
    is_expected.to have_content user.microposts.count.to_s
    
    user.microposts.paginate(page: 1).each do |micropost|
      is_expected.to have_content micropost.title
    end

  end

end
