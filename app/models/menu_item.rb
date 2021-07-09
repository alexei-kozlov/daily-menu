class MenuItem < ApplicationRecord
	validates :title, uniqueness: true, presence: true, length: { minimum: 3 }
	validates :category_id, presence: true
	validates :pricing_id, presence: true
	validates :volume, presence: true
	validates :unit_id, presence: true

	has_many :daily_menu_items, :dependent => :restrict_with_error, :foreign_key => :menu_item_id
	belongs_to :category
	belongs_to :pricing
	belongs_to :unit

	def self.search(search_name)
		return unless search_name.present?
		joins(:category).where(['menu_items.title LIKE :search_name OR categories.title LIKE :search_name', search_name:"%#{search_name}%"])
	end
end