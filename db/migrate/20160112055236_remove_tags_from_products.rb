class RemoveTagsFromProducts < ActiveRecord::Migration
  def change
  	remove_column :products, :tags
  end
end
