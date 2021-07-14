class AddQuantityPorToOrderItems < ActiveRecord::Migration[6.1]
  def change
    add_column :order_items, :quantity_por, :integer
    add_column :order_items, :quantity_vol, :integer
  end
end
