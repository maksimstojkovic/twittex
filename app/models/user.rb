class User < ApplicationRecord
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :trackable, :omniauthable

  has_many :follows_received, class_name: :Follow, foreign_key: :followee_id
  has_many :followers, through: :accepted_follower_requests, source: :follower

  has_many :follows_sent, class_name: :Follow, foreign_key: :follower_id
  has_many :followings, through: :accepted_following_requests, source: :followee

  # HELPERS

  def self.email_find_or_create_by(attributes = {})
    User.create(attributes) unless User.exists?(attributes.slice(:email))
  end
end
