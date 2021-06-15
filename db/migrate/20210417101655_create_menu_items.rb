class CreateMenuItems < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_items do |t|
      t.string :title
      t.integer :category_id
      t.integer :pricing_id
      t.integer :volume
      t.integer :unit_id

      t.timestamps
    end
  end
end
