class Micropost < ApplicationRecord
  belongs_to :user
  
  
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true  
  validates :content, presence: true, length: { maximum: 140 }
  validates :image,   content_type: { in: %w[image/jpeg image/png],
                                      message: "拡張子はjpeg jpg pngのみ有効です" },
                      size:         { less_than: 5.megabytes,
                                      message: "5MB以上の画像は扱えません" }
                                        
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end
