class MenuItem < ApplicationRecord
  validates :title, uniqueness: { message: "«%{value}» has already belongs to the category and cannot be included in another!" }, presence: { message: "can't be blank. Please, enter a title!" }, length: {minimum: 3}
  validates :category_id, presence: { message: "can't be blank. Please, select a category!" }
  validates :pricing_id, presence: { message: "can't be blank. Please, select a pricing type!" }
  validates :volume, presence: { message: "can't be blank. Please, enter a volume!" }
  validates :unit_id, presence: { message: "can't be blank. Please, select a unit!" }

  has_many :daily_menu_items, :dependent => :restrict_with_error, :foreign_key => :menu_item_id
  belongs_to :category
  belongs_to :pricing
  belongs_to :unit
end