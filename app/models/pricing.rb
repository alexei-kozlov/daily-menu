class Pricing < ApplicationRecord
   validates :pricing_type, uniqueness: { message: "«%{value}» has already been taken. Please, select a new %{model} type!" }, presence: { message: "can't be blank. Please, select a new %{model} type!" }
#    validates :volume_id, presence: true

   belongs_to :menu_item, optional: true
end
