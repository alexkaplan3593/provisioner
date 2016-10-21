class AddSlugToProductsAndTags < ActiveRecord::Migration
  def change
    add_column :products, :slug, :string
    add_column :tags, :slug, :string

  end
end
