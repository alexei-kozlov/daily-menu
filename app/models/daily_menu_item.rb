class DailyMenuItem < ApplicationRecord
  validates :menu_item_id, presence: true, uniqueness: { message: "has already included to the menu!" }
  validates :price, presence: true

  belongs_to :menu_item
end