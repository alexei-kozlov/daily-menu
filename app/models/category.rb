class Category < ApplicationRecord
  validates :title, presence: true

#   has_many :menu_items
end
