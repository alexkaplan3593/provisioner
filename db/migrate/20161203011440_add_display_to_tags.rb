class AddDisplayToTags < ActiveRecord::Migration
  def change
    add_column :tags, :display, :boolean
  end
end
