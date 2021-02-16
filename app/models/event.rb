class Event < ApplicationRecord
  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events
  enum status: { 車:1, 乗:2 }
  belongs_to :user
end
