class AddPrimeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :prime, :boolean
  end
end
