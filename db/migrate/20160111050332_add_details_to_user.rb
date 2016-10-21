class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :handle, :string
    add_column :users, :image, :string
  end
end
