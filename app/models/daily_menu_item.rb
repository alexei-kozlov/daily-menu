class DailyMenuItem < ApplicationRecord
	validates :menu_item_id, presence: true
	validates :price, presence: true

	belongs_to :menu_item
	belongs_to :daily_menu
	#------------------------------------------------
	belongs_to :order_item
end