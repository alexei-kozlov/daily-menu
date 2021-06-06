class AddUnitIdToMenuItems < ActiveRecord::Migration[6.1]
  def change
    add_column :menu_items, :unit_id, :integer
  end
end
