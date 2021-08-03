class Order < ApplicationRecord
	validates :total_cost, presence: true, numericality: { greater_than_or_equal_to: 0 }
	validates :daily_menu_id, presence: true

	belongs_to :daily_menu
	has_many :order_items, dependent: :destroy
	accepts_nested_attributes_for :order_items, allow_destroy: true
	validates_associated :order_items
end
