class MenuItem < ApplicationRecord
  validates :title, presence: true, length: {minimum: 3}
  validates :category, presence: true
  validates :price, presence: true
end
