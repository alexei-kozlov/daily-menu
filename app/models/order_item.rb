class OrderItem < ApplicationRecord
	validates :daily_menu_item_id, presence: false
	validates :quantity_por, presence: false, numericality: { greater_than_or_equal_to: 1 }, unless: :quantity_vol
	validates :quantity_vol, presence: false, numericality: { greater_than_or_equal_to: 100 }, unless: :quantity_por
	validates :cost, presence: false, numericality: { greater_than_or_equal_to: 0 }

	belongs_to :order
	belongs_to :daily_menu_item
end