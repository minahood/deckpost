



module ApplicationHelper
  require "uri"
    # ページごとの完全なタイトルを返します。
  def full_title(page_title = '')
    base_title = "Deck Post"
    if page_title.empty?
      base_title
    else
      page_title + " - " + base_title
    end
  end
  
  def text_url_to_link text

    URI.extract(text, ['https']).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"
      text.gsub!(url, sub_text)
    end
  
    return text
  end
  
  def deck_kind
    {   
    '---'=> nil,
    'デュエマ'=> 1, 
    'デュエプレ'=> 2,
    '遊戯王OCG'=> 3,
    '遊戯王DL'=> 4,
    '遊戯王RD'=> 5,
    'ポケカ'=> 6,
    'MTG'=> 7,
    'ヴァイス'=> 8,
    'ヴァンガード'=> 9,
    'バトスピ'=> 10,
    'バディファイト'=> 11,
    'WIXOSS'=> 12,
    'Z/X'=> 13,
    'スクコレ'=> 14,
    'FEサイファ'=> 15,
    'リセ'=> 16,
    'chaos'=> 17,
    'プレメモ'=> 18,
    'まほエル'=> 19,
    '白猫'=> 20
    }
  end
  
  def deck_intention
    {   
    '---': nil,
    '大会志向': "battle", 
    'ファンデッキ': "fan",
    '大会上位入賞': "winning",
    '大会優勝': "victory", 
    }
  end
  
  def deck_sort
    [
    ['投稿が新しい順', 'new'],
    ['いいねが多い順', 'likes'],
    ['お気に入りが多い順', 'bookmarks'],
    ['投稿が古い順', 'old'],
    #['いいねが少ない順', 'not_likes'] ,
    #['お気に入りが少ない順', 'not_bookmarks']
    ['人気(1日間)','hot_1day'],
    ['人気(1週間)','hot_1week'],
    ['人気(1か月間)','hot_1month']
    ]
    
  end
  
  def default_meta_tags
    {
      site: Settings.site.name,
      reverse: true,    # タイトルタグ内の表記順をページタイトル|サイトタイトルの順にする
      separator: '|',
      # title: ,          #デフォルトページタイトル
      # description: ,    デフォルトページディスクリプション
      # keywords:         デフォルトページキーワード
      
      canonical: request.original_url,
      og: default_og
    }
  end

  def default_og
    return if noindex?
    {
      title: :title,
      description: :description,
      type: Settings.site.meta.ogp.type,
      url: request.original_url,
      image: page_og_image,
      site_name: Settings.site.name,
      locale: 'ja_JP'
    }
  end

  def page_og_image
    @page_image||image_url(Settings.site.meta.ogp.image_path)
  end

  def noindex?
    false
  end
  
end
