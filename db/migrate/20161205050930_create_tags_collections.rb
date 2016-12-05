class CreateTagsCollections < ActiveRecord::Migration
  def change
    create_table :collections_tags do |t|

      t.belongs_to :collection, index: true
      t.belongs_to :tag, index: true

      t.timestamps

    end
  end
end
