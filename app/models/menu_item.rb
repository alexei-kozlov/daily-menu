class MenuItem < ApplicationRecord
  validates :title, presence: true, length: {minimum: 3}
  validates :price, presence: true

#   belongs_to :category
end
