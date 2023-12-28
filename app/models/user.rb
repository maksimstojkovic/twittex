class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :trackable, :omniauthable

  has_many :follows_received, class_name: :Follow, foreign_key: :followee_id
  has_many :pending_follower_requests, -> { where accepted: false }, class_name: :Follow, foreign_key: :followee_id
  has_many :accepted_follower_requests, -> { where accepted: true }, class_name: :Follow, foreign_key: :followee_id
  has_many :pending_followers, through: :pending_follower_requests, source: :follower
  has_many :followers, through: :accepted_follower_requests, source: :follower

  has_many :follows_sent, class_name: :Follow, foreign_key: :follower_id
  has_many :pending_following_requests, -> { where accepted: false }, class_name: :Follow, foreign_key: :follower_id
  has_many :accepted_following_requests, -> { where accepted: true }, class_name: :Follow, foreign_key: :follower_id
  has_many :pending_followings, through: :pending_following_requests, source: :followee
  has_many :followings, through: :accepted_following_requests, source: :followee
  
  # HELPERS

  def self.email_find_or_create_by(attributes = {})
    User.create(attributes) unless User.exists?(attributes.slice(:email))
  end
end
