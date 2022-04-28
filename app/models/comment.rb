class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :experience
  validates :experience_comment, presence: true
end
