class DailyMenu < ApplicationRecord
  validates :date, presence: true

  has_many :daily_menu_items, dependent: :destroy
  accepts_nested_attributes_for :daily_menu_items
  validates_associated :daily_menu_items
end
