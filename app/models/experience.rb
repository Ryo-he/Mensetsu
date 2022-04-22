class Experience < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_one_attached :image
 def favorited_by?(user)
    favorites.where(user_id: user).exists?
 end
end
