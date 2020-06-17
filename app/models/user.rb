class User < ApplicationRecord
  #before_save { email.downcase! }
  validates :name,presence: true, length: { maximum: 50 }
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, presence: true, length: { maximum: 255 },
  #                  format: { with: VALID_EMAIL_REGEX },
  #                  uniqueness: true
                    
  validates :login_id, presence: true,length: { maximum: 15 },uniqueness: true
  has_secure_password
  validates :password, length: { minimum: 4 }
end
