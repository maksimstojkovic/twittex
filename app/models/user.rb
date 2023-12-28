class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :trackable, :omniauthable

  has_many :follows, foreign_key: :followee
  has_many :follow_requests, -> { where accepted: false }, through: :follows, source: :follower
  has_many :followers, -> { where accepted: true }, through: :follows, source: :follower

  # HELPERS

  def self.email_find_or_create_by(attributes = {})
    User.create(attributes) unless User.exists?(attributes.slice(:email))
  end
end
