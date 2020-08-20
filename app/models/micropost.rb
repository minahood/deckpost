class Micropost < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :like_users,through: :likes,source: :user
  
  mount_uploader :image, ImageUploader
  
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true  
  validates :title ,presence:true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 1000 }
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
  def self.post_search(word,kind,intention)
    if intention.blank?
      return all if word.blank? && kind.blank?
      return Micropost.where(['title LIKE ?', "%#{word}%"]) if kind.blank?
      return Micropost.where(kind: kind) if word.blank?
      Micropost.where(kind: kind).where(['title LIKE ?', "%#{word}%"])
    else
      return Micropost.where(intention: intention).where(['title LIKE ?', "%#{word}%"]) if kind.blank?
      return Micropost.where(intention: intention).where(kind: kind) if word.blank?
      Micropost.where(intention: intention).where(['title LIKE ?', "%#{word}%"]).where(kind: kind)
    end
  end

  def self.post_sort(sort)
    case sort 
    when "new" ,nil then
      all
    when "old" then
      reorder(created_at: :ASC)
    when "likes" then
      reorder(likecount: :DESC,created_at: :DESC)
    when "not_likes" then
      reorder(likecount: :ASC,created_at: :DESC)
    when "bookmarks" then
      reorder(bookmarkcount: :DESC,created_at: :DESC)
    when "not_bookmarks" then
      reorder(bookmarkcount: :ASC,created_at: :DESC)
    when "hot_1month"
      to    = Time.current
      from  = (to - 1.month)
      where(created_at: from...to).reorder(likecount: :DESC,created_at: :DESC)
    when "hot_1week"
      to    = Time.current
      from  = (to - 1.week)
      where(created_at: from...to).reorder(likecount: :DESC,created_at: :DESC)
    when "hot_1day"  
      to    = Time.current
      from  = (to - 1.day)
      where(created_at: from...to).reorder(likecount: :DESC,created_at: :DESC)
    end
  end

  def create_notification_bookmark_by(current_user)
    temp = Notification.find_by([" micropost_id = ? and visited_id = ? and action = ? ", id, user_id,'bookmark'])
    if !temp.blank?
      temp.destroy
    end
    notification = current_user.active_notifications.new(
      micropost_id: id,
      visited_id: user_id,
      action: "bookmark"
    )
    if notification.visiter_id == notification.visited_id
      return
    end
    notification.save if notification.valid?
  end
  
  def create_notification_like_by(current_user)
    temp = Notification.find_by([" micropost_id = ? and visited_id = ? and action = ? ", id, user_id ,'like'])
    if !temp.blank?
      temp.destroy
    end
    notification = current_user.active_notifications.new(
      micropost_id: id,
      visited_id: user_id,
      action: "like"
    )
    if notification.visiter_id == notification.visited_id
      return
    end
    notification.save if notification.valid?
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(micropost_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      micropost_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知しない
    if notification.visiter_id == notification.visited_id
      return
    end
    notification.save if notification.valid?
  end
end
