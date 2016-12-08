class AddDisplayToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :display, :boolean
  end
end
