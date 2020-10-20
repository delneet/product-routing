class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :reference
      t.string :name
      t.string :category
      t.decimal :price

      t.timestamps
    end
  end
end
