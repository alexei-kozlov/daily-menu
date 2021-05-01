class Category < ApplicationRecord
  validates :title, presence: { message: "can't be blank. Please, select a %{model}!" }

#   has_many :menu_items, dependent: :destroy
#   validates_associated :menu_items
end
