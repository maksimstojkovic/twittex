class Comment < ApplicationRecord
  validates :body, presence: true, length: { minimum: 3 }

  belongs_to :post
  belongs_to :author, class_name: :User
end
