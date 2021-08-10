class OrderItem < ApplicationRecord
	validates :daily_menu_item_id, presence: false, :uniqueness => { scope: :order_id }
	validates :quantity_por, presence: false, numericality: { greater_than_or_equal_to: 1 }, unless: :quantity_vol
	validates :quantity_vol, presence: false, numericality: { greater_than_or_equal_to: 100 }, unless: :quantity_por

	belongs_to :order
	belongs_to :daily_menu_item

	after_validation :set_cost

	def calculate_cost
		if quantity_por.present?
			quantity_por * daily_menu_item.price
		elsif quantity_vol.present?
			(quantity_vol * daily_menu_item.price / daily_menu_item.menu_item.volume).round(2)
		end
	end

	def set_cost
		puts 'cost_calc'
		self.cost = if errors.empty?
						calculate_cost
					else
						0
					end
	end

end