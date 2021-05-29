class AddVolumeToMenuItems < ActiveRecord::Migration[6.1]
  def change
    add_column :menu_items, :volume, :integer
  end
end
