require 'rails_helper'

RSpec.describe 'Site layout', type: :request do
  subject {page}
  describe 'when aceess root_path /' do
    it "have each link" do
      visit root_path
      is_expected.to have_link nil, href: root_path
      is_expected.to have_link '使い方', href: help_path
      is_expected.to have_link 'このサイトについて', href: about_path
      is_expected.to have_link 'お問い合わせ', href: contact_path
      is_expected.to have_link 'News', href: news_path
    end
  end
end