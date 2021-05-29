class AddPricingTypeToMenuItems < ActiveRecord::Migration[6.1]
  def change
    add_column :menu_items, :pricing_type, :string
    add_column :menu_items, :unit, :string
  end
end
