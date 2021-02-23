class Event < ApplicationRecord
  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events
  enum status: { 車:1, 乗:2 }
  belongs_to :user
  validates:date,presence: true
  validate:not_past
  validates:title,presence: true
  validates:content,presence: true
  validates:start_point,presence: true
  validates:goal_point,presence: true
  validates:status,presence: true

  def not_past
    if date.nil? || date < Date.today
      errors.add(:base, '現在より新しい日付をいれてください')
    end
  end
end
