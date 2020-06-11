require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /home" do
    it "returns http success" do
      get root_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /help" do
    it "returns http success" do
      get help_url
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "GET /contact" do
    it "returns http success" do
      get contact_url
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "GET /about" do
    it "returns http success" do
      get about_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /news" do
    it "returns http success" do
      get news_url
      expect(response).to have_http_status(:success)
    end
  end
end
