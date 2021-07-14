class Order < ApplicationRecord
	validates :total_cost, presence: true
	# validates :daily_menu_id, presence: true

	has_many :order_items
	has_many :daily_menu_items, :through => :order_items, :dependent => :restrict_with_error, :foreign_key => :daily_menu_item_id
	accepts_nested_attributes_for :order_items, allow_destroy: true
	validates_associated :order_items
end
