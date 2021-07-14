class OrderItem < ApplicationRecord
	validates :daily_menu_item_id, presence: false
	validates :quantity_por, presence: false
	validates :quantity_vol, presence: false
	validates :cost, presence: false

	belongs_to :order
	has_one :daily_menu_item
end