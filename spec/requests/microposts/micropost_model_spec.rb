require 'rails_helper'

RSpec.describe Micropost, type: :request do
  include_context "user_setup"
  include_context "micropost_setup"

  describe "micropost model" do 
    before do
      @micropost = user.microposts.build(content: "Lorem insum",title: "神デッキ",kind: 2)
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

    it "content should be at most 1000 microppst" do
      @micropost.content = "a"*1001
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
  
  
  describe "post_search method /" do
    
    it "check assumed argument" do
      word = "s"
      kind = 2
      intention = "battle"
      expect(Micropost.post_search(word , kind ,intention)).to_not eq(nil)
      
      word = nil
      kind = 2
      intention = "battle"
      expect(Micropost.post_search(word , kind ,intention)).to_not eq(nil)
      
      word = nil
      kind = nil
      intention = "battle"
      expect(Micropost.post_search(word , kind ,intention)).to_not eq(nil)
      
      word = nil
      kind = 3
      intention = nil
      expect(Micropost.post_search(word , kind ,intention)).to_not eq(nil)
      
      word = nil
      kind = nil
      intention = nil
      expect(Micropost.post_search(word , kind ,intention)).to_not eq(nil)
      
      word = "s"
      kind = nil
      intention = "battle"
      expect(Micropost.post_search(word , kind ,intention)).to_not eq(nil)
      
      word = "s"
      kind = 4
      intention = nil
      expect(Micropost.post_search(word , kind ,intention)).to_not eq(nil)
      
      word = "s"
      kind = nil
      intention = nil
      expect(Micropost.post_search(word , kind ,intention)).to_not eq(nil)
    end
  end
end