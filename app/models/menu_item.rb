class MenuItem < ApplicationRecord
  validates :title, presence: true, length: {minimum: 3}
  validates :price, presence: true
  validates :category_id, presence: true

  belongs_to :category, optional: true
end
