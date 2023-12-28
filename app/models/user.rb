class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :trackable, :omniauthable

  has_many :follows, foreign_key: :followee
  has_many :follow_requests, -> { where accepted: false }, through: :follows, source: :follower
  has_many :followers, -> { where accepted: true }, through: :follows, source: :follower
end
