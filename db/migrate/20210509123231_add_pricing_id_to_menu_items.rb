class AddPricingIdToMenuItems < ActiveRecord::Migration[6.1]
  def change
    add_column :menu_items, :pricing_id, :integer
  end
end
