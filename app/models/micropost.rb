class Micropost < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  mount_uploader :image, ImageUploader
  
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true  
  validates :title ,presence:true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 400 }
  validates :kind ,presence:true
  
  
=begin
  has_one_attached :image
  validates :image,   content_type: { in: %w[image/jpeg image/png],
                                      message: "拡張子はjpeg jpg pngのみ有効です" },
                      size:         { less_than: 5.megabytes,
                                     message: "5MB以上の画像は扱えません" }

  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
=end
  def self.search(word,kind)
    return Micropost.all if word.blank? && kind.blank?
    return Micropost.where(['title LIKE ?', "%#{word}%"]) unless kind
    return Micropost.where(kind: kind) unless word
    Micropost.where(['title LIKE ?', "%#{word}%"]).where(kind: kind)
  end

  def bookmark_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end

end
