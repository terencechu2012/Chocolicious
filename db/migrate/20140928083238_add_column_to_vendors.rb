class AddColumnToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :reviewers, :integer
  end
end
