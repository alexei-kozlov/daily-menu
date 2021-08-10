class Order < ApplicationRecord
	validates :daily_menu_id, presence: true

	belongs_to :daily_menu
	has_many :order_items, dependent: :destroy
	accepts_nested_attributes_for :order_items, allow_destroy: true
	validates_associated :order_items

	after_validation :set_total_cost

	def set_total_cost
		self.total_cost = order_items.reject(&:marked_for_destruction?).sum(&:cost)
	end
end
