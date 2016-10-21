class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag_name
      t.integer :product_usage
      t.string :assoc_tags

      t.timestamps
    end
  end
end
