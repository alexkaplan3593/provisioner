class AddAmazonAsinToProducts < ActiveRecord::Migration
  def change
    add_column :products, :ASIN, :string
  end
end
