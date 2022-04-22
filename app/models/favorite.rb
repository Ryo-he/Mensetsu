class Favorite < ApplicationRecord
  belongs_to :user, foreign_key: true, null: false
  belongs_to :experience, foreign_key: true, null: false
  validates :user_id, uniqueness: { scope: :experience_id }
end
