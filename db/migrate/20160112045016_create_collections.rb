class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.integer :product_id
      t.integer :user_id
      t.string :collection_name

      t.timestamps
    end
  end
end
