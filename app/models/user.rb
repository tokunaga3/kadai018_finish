class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_events, dependent: :destroy
  has_many :events, through: :user_events
  validates:name,presence: true
  has_many :events, dependent: :destroy
end
