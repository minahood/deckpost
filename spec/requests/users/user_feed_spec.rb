require 'rails_helper'

RSpec.describe "user_feed /", type: :request do
  include_context "user_setup"
  include_context "micropost_setup"
  subject{page}

  describe "feed have right posts check/" do
    before do
      mike_post
      aya_post
      riko_post

      mike.follow(aya)
    end

    it "have follow_user post" do
      expect(mike.feed.include?(aya_post)).to eq(true)
    end

    it "have my post" do
      expect(mike.feed.include?(mike_post)).to eq(true)
    end

    it "dont have unfollow_user post" do
      expect(mike.feed.include?(riko_post)).to eq(false)
    end

  end
end
