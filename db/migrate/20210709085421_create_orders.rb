class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.float :total_cost
      t.integer :daily_menu_id

      t.timestamps
    end
  end
end
