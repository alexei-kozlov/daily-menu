class Unit < ApplicationRecord
   validates :unit_type, uniqueness: { message: "«%{value}» has already been taken. Please, select a new %{model}!" },
   presence: { message: "can't be blank. Please, select a new %{model}!" }

   has_many :menu_items, :dependent => :restrict_with_error, :foreign_key => :unit_id
   validates_associated :menu_items
end
