class AddCategoryToMenuItems < ActiveRecord::Migration[6.1]
  def change
    add_column :menu_items, :category, :string
  end
end
