require 'rails_helper'

RSpec.describe 'Site layout', type: :request do
  subject {page}
  describe 'when aceess root_path /' do
    it "have each link" do
      visit root_path
      is_expected.to have_link nil, href: top_path
      
      is_expected.to have_link 'サイトについて', href: about_path
      is_expected.to have_link 'お問い合わせ', href: contact_path
      #is_expected.to have_link '管理人ブログ', href: news_path
    end
  end
end