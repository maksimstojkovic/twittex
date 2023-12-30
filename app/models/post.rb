class Post < ApplicationRecord
  validates :body, presence: true, length: { minimum: 3 }

  belongs_to :author, class_name: :User

  has_many :likes
  has_many :comments, -> { order "created_at DESC" }

  scope :sort_desc, -> { order("created_at DESC") }
end
