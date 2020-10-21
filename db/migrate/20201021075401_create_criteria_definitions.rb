class CreateCriteriaDefinitions < ActiveRecord::Migration[6.0]
  def change
    create_table :criteria_definitions do |t|
      t.string :product_references, array: true, default: []
      t.string :product_categories, array: true, default: []
      t.decimal :max_product_price
      t.string :destination

      t.timestamps
    end
  end
end
