module ApplicationHelper
    # ページごとの完全なタイトルを返します。
  def full_title(page_title = '')
    base_title = "Deck Post"
    if page_title.empty?
      base_title
    else
      page_title + " - " + base_title
    end
  end
  
  def deck_kind
    {   
    '---': nil,
    'デュエマ': 1, 
    'デュエプレ': 2,
    '遊戯王OCG': 3,
    '遊戯王DL': 4,
    '遊戯王RD': 5,
    'ポケカ': 6,
    'ヴァイス': 7,
    'MTG': 8,
    'VG': 9,
    'バトスピ': 10,
    'バディファイト': 11,
    'WIXOSS': 12,
    'Z/X': 13,
    'スクコレ': 14,
    'FEサイファ': 15,
    'リセ': 16,
    'プレメモ': 17,
    'まほエル': 17,
    '白猫': 19
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
  
end
