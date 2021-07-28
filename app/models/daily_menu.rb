class DailyMenu < ApplicationRecord
	validates :date, presence: true

	has_many :orders, :dependent => :restrict_with_error
	has_many :daily_menu_items, dependent: :destroy
	has_many :menu_items, :through => :daily_menu_items, :dependent => :restrict_with_error, :foreign_key => :menu_item_id
	accepts_nested_attributes_for :daily_menu_items, allow_destroy: true
	validates_associated :daily_menu_items
end