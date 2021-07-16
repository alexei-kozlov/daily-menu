class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.integer :daily_menu_item_id
      t.integer :order_id
      t.integer :quantity_por
      t.integer :quantity_vol
      t.float :cost

      t.timestamps
    end
  end
end
