class DailyMenuItem < ApplicationRecord
  validates :menu_item_id, presence: true, uniqueness: { message: "has already included to the menu!" }
  validates :price, presence: true
#   validates :daily_menu_id, presence: true

  belongs_to :menu_item
#   belongs_to :daily_menu
end