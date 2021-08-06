class OrderItem < ApplicationRecord
	validates :daily_menu_item_id, presence: false
	validates :quantity_por, presence: false, numericality: { greater_than_or_equal_to: 1 }, unless: :quantity_vol
	validates :quantity_vol, presence: false, numericality: { greater_than_or_equal_to: 100 }, unless: :quantity_por
	validates :cost, presence: false, numericality: { greater_than_or_equal_to: 0 }

	belongs_to :order
	belongs_to :daily_menu_item

	after_validation :calculate_cost

	def cost
		if quantity_vol.present? && quantity_vol > 0
			(quantity_vol * daily_menu_item.price / daily_menu_item.menu_item.volume).round(2)
		elsif quantity_por.present? && quantity_por > 0
			quantity_por * daily_menu_item.price
		end
	end

	def calculate_cost
		self.cost = if errors.empty?
						cost
					else
						nil
					end
	end

end