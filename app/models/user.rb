class User < ApplicationRecord
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :trackable, :omniauthable

  has_many :follows_received, class_name: :Follow, foreign_key: :followee_id
  has_many :followers, through: :follows_received, source: :follower

  has_many :follows_sent, class_name: :Follow, foreign_key: :follower_id
  has_many :followings, through: :follows_sent, source: :followee

  has_many :posts, -> { order "created_at DESC" }, foreign_key: :author_id
  has_many :comments, -> { order "created_at DESC" }, foreign_key: :author_id

  scope :sort_username, -> { order "username ASC" }

  # HELPERS

  def self.email_find_or_create_by(attributes = {})
    User.create(attributes) unless User.exists?(attributes.slice(:email))
  end
end
