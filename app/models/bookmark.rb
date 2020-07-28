class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :user_id, uniqueness: { scope: :micropost_id } 
end
