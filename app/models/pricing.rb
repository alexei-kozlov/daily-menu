class Pricing < ApplicationRecord
   validates :pricing_type, presence: true
#    validates :volume_id, presence: true

   belongs_to :menu_item, optional: true
end
