class Post < ApplicationRecord
  has_many :comments
  validates :title, presence: true, length: {minimum: 5}
  validates :title, presence: true, length: {minimum: 100}
end
