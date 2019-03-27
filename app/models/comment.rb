class Comment < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  scope :of_user, -> (user_id){ where(user_id: user_id) }
  scope :by_user, -> { group('user_id') }
  scope :most_used, -> (count){ select('user_id, count(1) AS count').limit(count) }
end
