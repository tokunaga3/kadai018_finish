class Event < ApplicationRecord
  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events
  enum status: { 車（運転者として登録）:1, 乗（乗車として登録）:2 }

end
