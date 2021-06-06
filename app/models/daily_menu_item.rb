class DailyMenuItem < ApplicationRecord
  validates :menu_item_id, presence: { message: "can't be blank. Please, select a dish!" }
  validates :price, presence: { message: "can't be blank. Please, enter a price!" }

  belongs_to :menu_item
end