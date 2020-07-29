class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  has_many :microposts, dependent: :destroy
  has_many :bookmarks,dependent: :destroy
  has_many :bookmark_microposts,through: :bookmarks,source: :micropost
  has_many :comments, dependent: :destroy
  
  attr_accessor :remember_token
  #before_save { email.downcase! }
  validates :name,presence: true, length: { maximum: 30 }
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, presence: true, length: { maximum: 255 },
  #                  format: { with: VALID_EMAIL_REGEX },
  #                  uniqueness: true
  
  before_save { login_id.downcase! }
  VALID_LOGIN_ID_REGEX = /\A[a-zA-Z0-9]+\z/
  validates :login_id, presence: true,length: { minimum: 4,maximum: 15 },
                       format: { with: VALID_LOGIN_ID_REGEX },
                       uniqueness: true
  has_secure_password
  validates :password, length: { minimum: 4 },allow_nil: true
  
    # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
    # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
    # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
    # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
    # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end
  
  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
  
  def self.user_search(word,login_id)
    return User.all if word.blank? && login_id.blank?
    return User.where(['name LIKE ?', "%#{word}%"]) if login_id.blank?
    return User.where(['login_id LIKE ?', "%#{login_id}%"]) if word.blank?
    User.where(['name LIKE ?', "%#{word}%"]).where(login_id: login_id)
  end
end
