class MenuItem < ApplicationRecord
  validates :title, uniqueness: { message: "«%{value}» has already belongs to the category and cannot be included in another!" }, presence: true, length: {minimum: 3}
  validates :category_id, presence: true
  validates :pricing_type, presence: { message: "can't be blank. Please, select a pricing type!" }
  validates :volume, presence: true
  validates :unit, presence: { message: "can't be blank. Please, select a unit!" }

  belongs_to :category, optional: true
end