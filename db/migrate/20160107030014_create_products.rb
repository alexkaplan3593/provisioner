class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.decimal :price
      t.string :name
      t.string :image
      t.string :vendor
      t.integer :discoverer

      t.timestamps
    end
  end
end
