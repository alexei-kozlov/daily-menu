class CreatePricings < ActiveRecord::Migration[6.1]
  def change
    create_table :pricings do |t|
      t.string :pricing_type
      t.string :pricing_desc

      t.timestamps
    end
  end
end
