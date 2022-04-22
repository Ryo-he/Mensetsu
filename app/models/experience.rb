class Experience < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_one_attached :image
end