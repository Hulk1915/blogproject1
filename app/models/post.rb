class Post < ApplicationRecord

  has_many :comments
  validates :title, presence: true, length: { minimum: 5, maximum: 100, too_short: "слишком короткий заголовок надо (минимум %{count} символов)", too_long: "слишком длинный заголовок надо (максимум %{count} символов)" }
  validates :body, presence: true, length: { minimum: 10, too_short: "слишком короткое описание надо (минимум %{count} символов)" }

end
