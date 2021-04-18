class MenuItem < ApplicationRecord
  validates :title, presence: true, length: {minimum: 3}
  validates :price, presence: true
end
