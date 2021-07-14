class Order < ApplicationRecord
	validates :total_cost, presence: true
	validates :daily_menu_id, presence: false

	has_many :order_items
	belongs_to :daily_menu
	accepts_nested_attributes_for :order_items, allow_destroy: true
	validates_associated :order_items
end
