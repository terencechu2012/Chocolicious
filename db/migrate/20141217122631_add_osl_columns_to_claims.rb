class AddOslColumnsToClaims < ActiveRecord::Migration
  def change
    add_column :claims, :claimtype, :string
    add_column :claims, :approvedby, :string
  end
end
