class User < ApplicationRecord
  attr_accessor :remember_token
  #before_save { email.downcase! }
  validates :name,presence: true, length: { maximum: 50 }
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
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
    # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
end
