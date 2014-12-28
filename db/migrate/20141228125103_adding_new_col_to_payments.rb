class AddingNewColToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :item, :string
    add_column :payments, :claimtype, :string
    add_column :payments, :approvedby, :string
  end
end
