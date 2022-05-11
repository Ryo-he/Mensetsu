class Experience < ApplicationRecord
  validates :title, presence: true
  validates :situation, presence: true
  validates :time, presence: true
  validates :format, presence: true
  validates :atomosphere, presence: true
  validates :question, presence: true
  validates :impression, presence: true
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

 def self.sort_like
    Experience.all.sort{|a,b| b.favorites.size <=> a.favorites.size}
 end

end
