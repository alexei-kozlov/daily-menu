class Unit < ApplicationRecord
   validates :unit_type, uniqueness: true, presence: true

   has_many :menu_items, :dependent => :restrict_with_error, :foreign_key => :unit_id
   validates_associated :menu_items
end
