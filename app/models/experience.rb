class Experience < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_one_attached :image
 def favorited_by?(user)
    favorites.where(user_id: user).exists?
 end
 
 def self.sort(selection)
    case selection
    when 'new'
      return all.order(created_at: :DESC)
    when 'old'
      return all.order(created_at: :ASC)
    when 'favorite'
      return Experience.find(Favorite.group(:experience_id).order('count(post_id) desc').pluck(:post_id))
    when 'unfavorite'
      return Experience.find(Favorite.group(:experience_id).order('count(post_id) asc').pluck(:post_id))
    end
 end
  
end
