class AddAddressToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :address, :string
  end
end
