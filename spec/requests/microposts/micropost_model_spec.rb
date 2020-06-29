require 'rails_helper'

RSpec.describe Micropost, type: :request do
  include_context "user_setup"
  include_context "micropost_setup"

  describe "micropost model" do 
    before do
      @micropost = user.microposts.build(content: "Lorem insum")
    end

    it "should be valid" do
      expect(@micropost.valid?).to eq(true)
    end

    it "user_id should be present" do
      @micropost.user_id = nil
      expect(@micropost.valid?).to eq(false)
    end

    it "content should be present" do
      @micropost.content = "   "
      expect(@micropost.valid?).to eq(false)
    end

    it "content should be at most 140 microppst" do
      @micropost.content = "a"*141
      expect(@micropost.valid?).to eq(false)
    end

    it "micropost user_id check" do
      expect(@micropost.user_id).to eq(user.id)
    end
  end

  it "order should be most recent first" do
    user_post
    user_posts
    user_post_recent
    expect(User.first.microposts.count).to eq(user_posts.count + 1 + 1)
    expect(user_post_recent).to eq Micropost.first
    expect do 
      user_post.user.destroy
    end.to change(Micropost, :count).by(-1*(user_posts.count + 1 + 1))
  end
  
end