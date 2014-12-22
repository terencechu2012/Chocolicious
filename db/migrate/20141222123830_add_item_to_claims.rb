class AddItemToClaims < ActiveRecord::Migration
  def change
    add_column :claims, :item, :string
  end
end
