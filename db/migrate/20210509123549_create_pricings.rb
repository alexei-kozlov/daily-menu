class CreatePricings < ActiveRecord::Migration[6.1]
  def change
    create_table :pricings do |t|
      t.string :pricing_type
      t.integer :volume_id

      t.timestamps
    end
  end
end
