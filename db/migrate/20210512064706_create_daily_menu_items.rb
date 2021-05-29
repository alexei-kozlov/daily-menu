class CreateDailyMenuItems < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_menu_items do |t|
      t.integer :menu_item_id
      t.integer :daily_menu_id
      t.float :price

      t.timestamps
    end
  end
end
