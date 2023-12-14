class Post < ApplicationRecord
  has_many :comments
  validates :title, presence: true, length: {minimum: 5}
  validates :title, presence: true, length: {maximum: 100}
  validates :body, presence: true, length: {minimum: 10}
end
