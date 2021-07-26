class Order < ApplicationRecord
	validates :total_cost, presence: true
	validates :daily_menu_id, presence: false

	belongs_to :daily_menu
	has_many :order_items, dependent: :destroy
	# has_many :daily_menu_items, :through => :order_items, :dependent => :restrict_with_error, :foreign_key => :daily_menu_item_id
	accepts_nested_attributes_for :order_items, allow_destroy: true
	validates_associated :order_items
end
