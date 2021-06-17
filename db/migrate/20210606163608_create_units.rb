class CreateUnits < ActiveRecord::Migration[6.1]
  def change
    create_table :units do |t|
      t.string :unit_type
      t.string :unit_desc

      t.timestamps
    end
  end
end
