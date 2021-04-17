class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_events, dependent: :destroy
  has_many :events, through: :user_events
  validates:name,presence: true
  has_many :events, dependent: :destroy
  mount_uploader :image, ImageUploader

  has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :event_comments  

  def follow!(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end

  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def self.guest
     find_or_create_by!(name: 'ゲスト', email: 'guest@example.com') do |user|
       user.password = SecureRandom.urlsafe_base64
     end
  end
end
