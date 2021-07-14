class AddDailyMenuIdToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :daily_menu_id, :integer
  end
end
