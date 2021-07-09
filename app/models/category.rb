class Category < ApplicationRecord
	validates :title, uniqueness: true, presence: true

	has_many :menu_items, :dependent => :restrict_with_error, :foreign_key => :category_id
	validates_associated :menu_items
end