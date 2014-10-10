class AddCreditlimitToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :creditlimit, :string
  end
end
