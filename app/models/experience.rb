class Experience < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image
 def favorited_by?(user)
    favorites.where(user_id: user).exists?
 end

 def self.search(keyword)
  where(["name like?", "%#{keyword}%"])
 end
 
end
