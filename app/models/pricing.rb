class Pricing < ApplicationRecord
   validates :pricing_type, uniqueness: true, presence: true

   has_many :menu_items, :dependent => :restrict_with_error, :foreign_key => :pricing_id
   validates_associated :menu_items
end
