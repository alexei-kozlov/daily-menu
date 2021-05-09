class MenuItem < ApplicationRecord
  validates :title, uniqueness: { message: "«%{value}» has already belongs to the category and cannot be included in another!" }, presence: true, length: {minimum: 3}
  validates :price, presence: true
  validates :category_id, presence: true

  belongs_to :category, optional: true
  has_one :pricing
end
